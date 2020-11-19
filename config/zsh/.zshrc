[[ "$SIMPLE_MODE" = "yes" ]] && {
  source $ZDOTDIR/.zshrc.minimal
  return
}

# set environments
ENV_OS="linux"
ENV_FONT_DIR="$HOME/.local/share/fonts"
ENV_DOT_CONFIG="$HOME/.config"
## for macos
which sw_vers &> /dev/null && {
  ENV_OS="(macos|darwin)"
  ENV_FONT_DIR="$HOME/Library/Fonts"
}

# enable completions
autoload -U compinit && compinit

set -o emacs

# zinit

[[ -f "$ZDOTDIR/.zinit/zinit.zsh" ]] && source "$ZDOTDIR/.zinit/zinit.zsh"
[[ -f "$ZDOTDIR/.zinit/bin/zinit.zsh" ]] && source "$ZDOTDIR/.zinit/bin/zinit.zsh" 
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

type zinit &> /dev/null && {
  mkdir -p $ZPFX/{bin,man/man1,share}
}

# fzf
zinit ice as"program" \
  pick"$ZPFX/bin/fzf" \
  atclone"cp -vf bin/fzf $ZPFX/bin/; cp -vf man/man1/fzf $ZPFX/man/man1" \
  atpull"%atclone" \
  make"!PREFIX=$ZPFX install"
zinit load junegunn/fzf
type fzf &> /dev/null && {
  # fzf
  export FZF_DEFAULT_OPTS="-1 -0 --cycle --reverse --height=40% --border"
  export FZF_DEFAULT_COMMAND="fd --type=f --exclude .git --hidden --follow"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
}

zinit ice as"program" pick"bin/anyenv" atload'export ANYENV_ROOT=$PWD; eval "$(anyenv init -)"' \
  atclone"anyenv install --init"
zinit light anyenv/anyenv

type anyenv &> /dev/null && {
  echo {pl,py,go}env | fmt -1 | while read XENV; do 
    type $XENV &> /dev/null || anyenv install $XENV
  done
}

zinit ice has"plenv" cloneonly \
  atclone"mkdir -p $(plenv root)/plugins/perl-download && cp -r * $(plenv root)/plugins/perl-download" \
  atpull"%atclone"
zinit light skaji/plenv-download

# フォント系
zinit from"gh-r" cloneonly for \
  cp"./*.ttf -> $ENV_FONT_DIR/Cica" bpick"*_with_emoji.zip"            miiton/Cica \
  cp"./HackGenNerd_*/*.ttf -> $ENV_FONT_DIR/HackGenNerd" bpick"*Nerd*" yuru7/HackGen

# go install系
zinit has"go" atclone"go install" atpull"%atclone" as"null" for \
  atload'eval "$(go-cdx --init)"'       xztaityozx/go-cdx \
  atload'source $ZDOTDIR/powerline.zsh' justjanne/powerline-go \
                                        x-motemen/ghq

zinit cloneonly as"null" for \
  cp"plug.vim -> $HOME/.local/share/nvim/site/autoload/plug.vim" junegunn/vim-plug \
  has"tilix" cp"./*/*.json -> $ENV_DOT_CONFIG/tilix/schemes"     storm119/Tilix-Themes

zinit as"program" from"gh-r" for \
  pick"*/rg"         BurntSushi/ripgrep \
  pick"*/delta"      dandavison/delta \
  pick"./*/trdsql"   noborus/trdsql \
  pick"$ZPFX/bin/googler" make"install PREFIX=$ZPFX" jarun/googler \
  pick"*/ocs"                      xztaityozx/ocs \
  bpick"*.tar.gz" pick"bin/teip"   greymd/teip \
  pick"*/bin/gh"                   cli/cli \
  pick"./*/bin/nvim"               neovim/neovim \
  pick"./*/bat"                    @sharkdp/bat \
  pick"*/fd"                       @sharkdp/fd \
  pick"*/trigger" has"inotifywait" @sharkdp/trigger \
  pick"*/sel"     cp"*/sel-completion.zsh -> _sel" xztaityozx/sel \
  jesseduffield/lazygit \
  pemistahl/grex \
  tomnomnom/gron \
  lotabout/rargs \
  dom96/choosenim

zinit ice as"program" pick"gibo" atclone"chmod +x gibo && gibo update" atpull"%atclone"
zinit light simonwhitaker/gibo

# exa
zinit ice from"gh-r" as"program" bpick"*$ENV_OS*" cp"exa* -> exa"  atclone" \
  curl -fLo $ZDOTDIR/.zinit/completions/_exa https://raw.githubusercontent.com/ogham/exa/master/contrib/completions.zsh" \
  atpull"%atclone"
zinit light ogham/exa

# pynvim
zinit ice has"pip3" atclone"pip3 install ." atpull"%atclone" pick"/dev/null"
zinit light neovim/pynvim

# hub
zinit ice from"gh-r" atclone"tar xzf *.tgz && cp ./*/*/hub ./hub && rm -rf hub-*" \
  bpick"*$ENV_OS*" pick"./*/*/hub" cp"./*/etc/hub.zsh_completion -> $ZDOTDIR/.zinit/completions/_hub" \
  as"program" \
  atpull"%atclone"
zinit light github/hub

# httpie
#zinit ice has"pip3" as"program" atclone"pip3 install . --user" pick"/dev/null" atpull"%atclone" atdelete"pip3 uninstall -y httpie"
#zinit light httpie/httpie

# zsh-utils
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
#!bin/zsh

# 置き換えツール
type exa &> /dev/null && alias ls="exa --git"
type bat &> /dev/null && alias cat="bat --theme TwoDark"
# {{{
  # $_.cat とすれば、直前にlsとかnvimしたファイルをcatできる。あんまつかわん
  alias -s cat='(){cat ${1/.cat/}}'
  alias catf="(){tail -f \${@} | cat -l log --paging=never}"
  alias fcat="fzf --preview 'bat --theme TwoDark --style=numbers --color=always --line-range :500 {}' | :awk '{print \$1}' | icat"
# }}}
type hexyl &> /dev/null && alias xxd=hexyl
type httpie &> /dev/null && alias curl=httpie
type gsed &> /dev/null && alias sed=gsed
type ggrep &> /dev/null && alias grep=ggrep
type grm &> /dev/null && alias rm=grm
type gpaste &> /dev/null && alias paste=gpaste
type gmkdir &> /dev/null && alias mkdir=gmkdir

# typo
alias ks=ls
alias ka=ls
alias lks=ls

# cdx
alias cg="cdx -c g"
alias ch="cdx -h"
alias cb="cdx -b"
alias ..="cdx ../"
alias cdoc='cdx $(doc -r)'

# hub
alias hs="hub status"
alias hac="hub add -A && hub commit -m"
alias hpl="hub pull"
alias hps="hub push"
alias hsw="hub switch"
alias hg="hub grep"
type rg &> /dev/null && unalias hg && alias hg="rg --vimgrep"
alias hd="hub diff"
alias hl="hub log"
alias hst="hub stash"
alias hub-push-current="hub push origin HEAD"
alias hsf="hub status --short | fzf -m"
alias hswf="hub branch --list | fzf | xargs hub switch"

# lazygit
type lazygit &> /dev/null && alias lg=lazygit

# fcitx
type fcitx &> /dev/null && alias fcitx-autostart="fcitx-autostart &> /dev/null"

# for touchpad gesture
type libinput-gestures-setup &> /dev/null && alias gesrestart="libinput-gestures-setup restart"

# python3
alias py3=python3

# go
alias -s go="go run "

# perl
alias -s pl="perl -Ilib"
alias -s psgi="carton exec -- plackup -Ilib"
alias care="carton exec"
alias ple="plenv exec"
alias care-run="carton exec perl -Ilib"

# シンプルなプロンプトなbash
alias simple-bash='PS1="> " bash'

# zinitとかをロードしないzshを起動
alias simple-zsh='SIMPLE_MODE="yes" zsh'

# 現在シェルを置き換え
alias relaunch-shell="exec $SHELL -l"

# 文字列をURLエンコード
alias urlize='nkf -WwMQ | tr = %'
alias unurlize='nkf -w --url-input' 

# googlerをw3mで起動したい
type w3m &> /dev/null && type googler &> /dev/null && alias googler="BROWSER=w3m googler"

# :e で EDITOR を起動する
[[ -z "$EDITOR" ]] || alias :e="$EDITOR"
# zsh bindings
bindkey ";5C" forward-word
bindkey ";5D" backward-word
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char

__insert_awk__(){
  local TEXT="awk '{}'"
  BUFFER=${BUFFER:0:$CURSOR}$TEXT${BUFFER:$CURSOR}
  CURSOR=$(($CURSOR+6))
}
zle -N __insert_awk__
bindkey "^Xawk" __insert_awk__

__edit_line__(){
  local FILE="/tmp/$(date "+%s")line.sh"
  echo "$BUFFER" > $FILE &&
    nvim $FILE &&
  BUFFER=$(cat $FILE) &&
  CURSOR=${#BUFFER}
}

zle -N __edit_line__
bindkey "^Xe" __edit_line__

__local_branch_widget__() {
  local result="$(hub branch | sed 's/[ *]*//g' | fzf)"
  local ret=$?
  zle reset-prompt
  BUFFER=${BUFFER}" "${result}
  CURSOR=${#BUFFER}
  return $ret
}

zle -N __local_branch_widget__
bindkey "^Xb" __local_branch_widget__

__remote_branch_widget__() {
  local result="$(hub branch --remotes | sed 's/[ *]*//g' | fzf)"
  local ret=$?
  zle reset-prompt
  BUFFER=${BUFFER}" "${result}
  CURSOR=${#BUFFER}
  return $ret
}

zle -N __remote_branch_widget__
bindkey "^XB" __remote_branch_widget__
#!/usr/bin/zsh

# ggc user/repo
# ghq get hoge/fuga && cd $(ghq root)/github.com/hoge/fuga
function ggc() {
  local repo="$1"
  ghq get $repo &&
    cd $(ghq root)/github.com/$repo
}

function hub-remote-set-ssh() {
  local repo="$(basename $(pwd))"
  hub remote set-url origin git@github.com:xztaityozx/$repo
}

# output information to stdout
# usage: logger.info [text]
function logger.info() {
  echo "\033[34m[info] [$(date)]\033[39m $*"
}

# output warning to stdout
# usage: logger.warn [text]
function logger.warn() {
  echo "\033[33m[warn] [$(date)]\033[39m $*"
}

# copy text to clipboard
# usage:
#   - yy [text] -> copy [text] to clipboard
#   - [command] | yy -> copy [command]'s output to clipboard
#   - yy -> copy last command
function yy() {
  local text="${*}"
  [ -p /dev/fd/0 ] && text=$(cat -)
  [ "$text" = "" ] && text="$(history | tail -n1 |cut -d' ' -f4-)"

  # wsl
  type clip.exe 2>&1 > /dev/null && echo -n "$text" | clip.exe && return 0
  # xclip
  type xclip 2>&1 > /dev/null && echo -n "$text" | xclip -selection c && return 0
  # xsel 
  type xsel 2>&1 > /dev/null && echo -n "$text" | xsel -b && return 0
  # pbcopy
  type pbcopy 2>&1 > /dev/null && echo -n "$text" | pbcopy && return 0

  logger.warn "clip.exe, xclip, pbcopy or xsel not found"
}

# icat STDINからやってきた文字列をパスとしてcatにわたす。複数行あるなら fzf で選択する
function icat() {
  local file="$(fzf)"
  cat $file
}

# config, open config file
function config() {
  cd $ZDOTDIR
  local file="$(ls -la|grep -v "^d"|awk '{print $NF}'|fzf)"
  [[ "$file" = "" ]] && logger.warn "fzf was canceled" && return 1

  nvim $file
}

# reconfigure
function rescale() {
  [ "$1" = "HDMI" ] && gsettings set org.gnome.desktop.interface scaling-factor 2 &&
  xrandr --output HDMI1 --scale 1x1 &&
  xrandr --output HDMI1 --scale 1.2x1.2 &&
  xrandr --output HDMI1 --panning 2304x1440 && exit

  gsettings set org.gnome.desktop.interface scaling-factor 2
  xrandr --output DSI1 --scale 1x1
  xrandr --output DSI1 --scale 1.2x1.2
  xrandr --output DSI1 --panning 2304x1536
}

# awk for csv
function cawk() {
  awk -F, "$@"
}

# awk のセパレータを : にしたやつ
function :awk() {
  awk -F: "$@"
}

function ohiru() {
  local verb="${1:-begin}"
  local emoji=":ohiru"
  [[ "$verb" = "end" ]] && emoji="${emoji}_owari"

  echo "$emoji: $(date)"
}

# $PATH を見やすく表示するだけ
function path-list() {
  echo "$PATH" | tr : \\n
}

# ど゛う゛し゛て゛な゛ん゛だ゛よ゛お゛お゛お゛お゛お゛お゛お゛お゛お゛お゛お゛お゛お゛お゛お゛
function fujitatsulize() {
  cat | sed 's/./&゛/g'
}

# wget wgetのラッパー、自動で/tmp/zsh/wgetに移動して、作業ディレクトリとしてつかう
function wget-tmp() {
  local dir="$TMPPREFIX/wget"

  echo "$dirで作業する？"
  yesno
  [[ "$?" == "0" ]] && {
    mkdir -p ${dir}
    cd ${dir}
  }
  \wget "$@"
}
alias wget=wget-tmp

# YYYYmmddを出力するだけ
function simple-date() {
  date '+%Y%m%d'
}

# 本日分のドキュメントを編集/作成するコマンド
# 日報とかTODOとかを $HOME/Documents/cli-doc/以下に作る
# flags:
#   -f | --file: ファイル名をSTDOUTに出力して終了する
#   -r | --root: ドキュメントルートへのパスをSTDOUTに出力して終了する
function doc() {
  local docDir="$HOME/Documents/cli-doc"

  : "-r | --root" && [[ "$1" =~ "^(-r|--root)$" ]] && echo $docDir && return 0;

  local date="$(simple-date)"

  # 種類とテンプレの連想配列
  typeset -A template=(
    "worklog" "${date} 作業ログ($USER)\n# ひとこと\n\n# やったこと\n"
    "todo"    "TODO:\n[] \n[] 出勤ボタン\n[] 退勤ボタン\n終了目安：17:00"
  )
  
  # fzfで編集したいのを選択
  local target=$(echo ${(k)template} |fmt -1| column -t | fzf | awk '{print $1}')
  [[ "$target" = "" ]] && logger.warn "doc command was canceled" && return 1


  local dir="$docDir/${target}"
  : "ディレクトリがなければ作る。失敗したら死ぬ" && [[ -d "$dir" ]] || mkdir -p $dir || {
    logger.warn "failed to mkdir $dir"
    return 1
  }
  local file="$dir/${date}.md"

  : "-f|--fileが有効ならSTDOUTに出して終了。それ以外ならテンプレを吐き出したりしてnvimにわたす" && [[ "$1" =~ "^(-f|--file)$" ]] && echo $file || {
    [[ -f "$file" ]] || echo -e "${template[$target]}" > $file
    nvim $file
  }
}

# fzf を使った yes/no プロンプト
function yesno() {
  local res="$(echo 'yes
no' | fzf)"
  [[ "$res" == yes ]] && return 0
  return 1
}

# hr
# 水平線を出力するだけのコマンド
# params:
#   str: 文字
#   width: 幅
function hr() {
  local str="${1:-=}";
  local width="${2:-80}";
  local length="${#str}"

  local current=0
  while :; do 
    [[ "$current" -ge "$width" ]] && echo "" && return 0
    printf "%s" "$str"
    current=$((current+length))
  done
}

# コメントヘッダを出力するだけのコマンド
# params:
#   width: 幅(default: 80)
#   type: ファイルタイプ(入力無しでのときfzfで選ぶ)
function com-header() {
  typeset -A header_dict=(
    "sh" "$(hr '#' $width)\n# \n$(hr '#' $width)"
    "tt2" "[%#\n$(hr '-' $width)\n\n$(hr '_' $width)\n$(hr '-' $width)\n#%]"
  )

  local width="${1:-80}"
  local ft="${2:-$(echo ${(k)header_dict} | fmt -1 | fzf | awk '{print $1}')}"

  echo -e ${header_dict[$ft]}
}


# 文字を大文字にするだけ
function upper() {
  sed 's/./\U&/g'
}

# 文字を小文字にするだけ
function lower() {
  sed 's/./\L&/g'
}

# wrap ( line  ) みたいな感じに包む
#   params:
#     $1: 開始記号
#     $2: 終端記号、省略すると$1
function wrap() {
  sed "s/.*/${1}&${2:-$1}/"
}

#!/usr/bin/zsh

setopt extended_glob

typeset -A abbreviations
abbreviations=(
    "G"    "| grep"
    "X"    "| xargs"
    "T"    "| tail"
    "H"    "| head"
    "W"    "| wc"
    "A"    "| awk '{}'"
    "S"    "| sed ''"
    "DN"   "&> /dev/null"
    "YY"   "| yy"
    "SUS"  "| sort | uniq -c | sort -rn"
    "FC"   "| fcat"
)

magic-abbrev-expand() {
    local MATCH
    LBUFFER=${LBUFFER%%(#m)[-_a-zA-Z0-9]#}
    LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
    zle self-insert

}

no-magic-abbrev-expand() {
    LBUFFER+=' '

}

zle -N magic-abbrev-expand
zle -N no-magic-abbrev-expand
bindkey " " magic-abbrev-expand
bindkey "^x " no-magic-abbrev-expand
test -e "${ZDOTDIR}/.iterm2_shell_integration.zsh" && source "${ZDOTDIR}/.iterm2_shell_integration.zsh"
