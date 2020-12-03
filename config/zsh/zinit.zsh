# zinit

[[ -f "$ZDOTDIR/.zinit/zinit.zsh" ]] && source "$ZDOTDIR/.zinit/zinit.zsh"
[[ -f "$ZDOTDIR/.zinit/bin/zinit.zsh" ]] && source "$ZDOTDIR/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

type zinit &> /dev/null && {
  mkdir -p $ZPFX/{bin,man/man1,share}
}

zinit ice as"program" nocompletions pick"powerline-go" cp"powerline-go* -> powerline-go" nocompile atload"source $ZDOTDIR/powerline.zsh"
zinit load justjanne/powerline-go

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

function _zinit_anyenv_atload() {
  eval "$(anyenv init - zsh)"
  echo {go,pl,py}env | fmt -1 | xargs -n1 anyenv install --skip-existing
  
  zinit ice has"plenv" cloneonly nocompile \
    atclone"mkdir -p $(plenv root)/plugins/perl-download && cp -r * $(plenv root)/plugins/perl-download" \
    atpull"%atclone"
  zinit light skaji/plenv-download

  unfunction $0
}

zinit ice wait lucid as"program" pick"bin/anyenv" \
  atload'export ANYENV_ROOT=$PWD;_zinit_anyenv_atload' \
  atclone"anyenv install --init" atpull"anyenv install --update;%atclone"
zinit light anyenv/anyenv

# フォント系
zinit from"gh-r" cloneonly nocompile for \
  cp"./*.ttf -> $ENV_FONT_DIR/Cica" bpick"*_with_emoji.zip"            miiton/Cica \
  cp"./HackGenNerd_*/*.ttf -> $ENV_FONT_DIR/HackGenNerd" bpick"*Nerd*" yuru7/HackGen

# go install系
zinit has"go" atclone"go install" atpull"%atclone" as"null" for \
  x-motemen/ghq

zinit cloneonly as"null" for \
  cp"plug.vim -> $HOME/.local/share/nvim/site/autoload/plug.vim" junegunn/vim-plug \
  has"tilix" cp"./*/*.json -> $ENV_DOT_CONFIG/tilix/schemes"     storm119/Tilix-Themes


function _zinit_bat_atload() {
  export MANPAGER="sh -c 'col -xb | bat --theme TwoDark -l man -p'"
  alias cat="bat --theme TwoDark"
  unfunction $0
}

zinit wait lucid as"program" from"gh-r" for \
  pick"*/rg"         BurntSushi/ripgrep \
  pick"*/delta"      dandavison/delta \
  pick"$ZPFX/bin/googler" make"install PREFIX=$ZPFX" jarun/googler \
  pick"*/ocs"                      xztaityozx/ocs \
  bpick"*.tar.gz" pick"bin/teip"   greymd/teip \
  pick"*/bin/gh"                   cli/cli \
  pick"./*/bin/nvim"               neovim/neovim \
  pick"./*/bat" cp"./*/autocomplete/bat.zsh -> _bat" atload"_zinit_bat_atload"  @sharkdp/bat \
  pick"*/fd"                       @sharkdp/fd \
  pick"*/trigger" has"inotifywait" @sharkdp/trigger \
  pick"*/sel"     cp"*/sel-completion.zsh -> _sel" xztaityozx/sel \
  pick"*/go-cdx"  atload"eval '$(go-cdx --init)'"  xztaityozx/go-cdx \
  atload"alias lg=lazygit" jesseduffield/lazygit \
  pick"*/csvq" mithrandie/csvq \
  pemistahl/grex \
  tomnomnom/gron \
  lotabout/rargs \
  dom96/choosenim

zinit ice wait lucid as"program" pick"gibo" atclone"chmod +x gibo && gibo update" atpull"%atclone"
zinit light simonwhitaker/gibo

zinit ice wait lucid depth"1" as"program" cp"share/zsh.txt -> _cht" atclone"curl https://cht.sh/:cht.sh > cht.sh" atpull"%atclone" pick"cht.sh"
zinit light chubin/cheat.sh

# exa
function _zinit_exa_atload() {
  alias ls="exa --git"
  unfunction $0
}
zinit ice wait lucid from"gh-r" as"program" bpick"*$ENV_OS*" cp"exa* -> exa"  atclone" \
  curl -fLo $ZDOTDIR/.zinit/completions/_exa https://raw.githubusercontent.com/ogham/exa/master/contrib/completions.zsh" \
  atpull"%atclone" \
  atload"_zinit_exa_atload"
zinit light ogham/exa

# pynvim
zinit ice lucid wait has"pip3" atclone"pip3 install ." atpull"%atclone" pick"/dev/null"
zinit light neovim/pynvim

# hub
zinit ice lucid wait from"gh-r" atclone"tar xzf *.tgz && cp ./*/*/hub ./hub && rm -rf hub-*" \
  bpick"*$ENV_OS*" pick"./*/*/hub" cp"./*/etc/hub.zsh_completion -> $ZINIT[COMPLETIONS_DIR]/_hub" \
  as"program" \
  atpull"%atclone"
zinit light github/hub

# httpie
zinit ice wait lucid has"pip3" as"program" atclone"pip3 install ." pick"/dev/null" atpull"%atclone" atdelete"pip3 uninstall -y httpie"
zinit light httpie/httpie

# zsh-utils
zinit wait lucid for \
  light-mode zsh-users/zsh-autosuggestions \
  light-mode zdharma/fast-syntax-highlighting \
  light-mode atload'zicompinit;zicdreplay' blockf zsh-users/zsh-completions
