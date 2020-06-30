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

# tnvim
# シュッとメモをとるときに使う
function tnvim() {
  mkdir -p /tmp/tnvim
  local file="/tmp/tnvim/$(date '+%s')"
  nvim ${file}
}

# cat last $_
# cat $_ するコマンド
function tt() {
  local file="$(history | tail -n1|awk '{print $NF}')"
  cat ${file}
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
    "todo"    "TODO:\n[] "
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

# file-hook [command] [target]
# params:
#   command: 実行したいコマンド
#   target:  監視したいファイル、もしくはディレクトリ。空にするとカレント以下を再帰的に見る
function file-hook() {
  local cmd="${1}"
  local target=${2:-./}
  local interval=${3:-10}

  [[ "$cmd" = "" ]] && logger.warn "コマンドが空です" && return 1;

  local sha=""
  local sum_cmd="sha256sum $target"
  [[ -d "${target}" ]] && sum_cmd="fd . --full-path $target --type=file | sort | xargs -n1 sha256sum | sha256sum"

  while true; do
    local update="$(eval $sum_cmd)"
    [[ "$update" != "$sha" ]] && {
      logger.info "file-hook >>> $cmd"
      sha="$update"
      eval "$cmd"
      sleep ${interval}s
    }
  done
}
