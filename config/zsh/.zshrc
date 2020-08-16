
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

true

# zinit
[[ -f "$ZDOTDIR/.zinit/zinit.zsh" ]] && source "$ZDOTDIR/.zinit/zinit.zsh"
[[ -f "$ZDOTDIR/.zinit/bin/zinit.zsh" ]] && source "$ZDOTDIR/.zinit/bin/zinit.zsh" 
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# fzf
FZF_PREFIX="$ZDOTDIR/.zinit/plugins/junegunn---fzf-bin"
FZF_URL="https://raw.githubusercontent.com/junegunn/fzf/master/shell"
zinit ice from"gh-r" as"program" atclone" \
  curl -fLo $FZF_PREFIX/scripts/completion.zsh --create-dirs $FZF_URL/completion.zsh && curl -fLo $FZF_PREFIX/scripts/key-bindings.zsh --create-dirs $FZF_URL/key-bindings.zsh" \
  atpull'%atclone' atload"source $FZF_PREFIX/scripts/key-bindings.zsh && source $FZF_PREFIX/scripts/completion.zsh"
zinit light junegunn/fzf-bin

type fzf &> /dev/null && {
  # fzf
  export FZF_DEFAULT_OPTS="-1 -0 --cycle --reverse --height=40% --border"
  export FZF_DEFAULT_COMMAND="fd --type=f --exclude .git --hidden --follow"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
}

# plenv
zinit ice as"program" pick"bin/plenv" atload'eval "$(plenv init - zsh)"' \
  atclone"git clone git://github.com/tokuhirom/Perl-Build.git ./plugins/perl-build/" atpull"%atclone"
zinit light tokuhirom/plenv

# Cica
zinit ice from"gh-r" cloneonly bpick"*_with_emoji.zip" atclone" \
  mkdir -p $ENV_FONT_DIR/Cica &> /dev/null
  cp ./* $ENV_FONT_DIR/Cica
" atpull"%atclone"
zinit light miiton/Cica

zinit ice from"gh-r" cloneonly bpick"*Nerd*" atclone" \
  mkdir -p $ENV_FONT_DIR/HackGenNerd &> /dev/null && 
  cp ./HackGenNerd_*/* $ENV_FONT_DIR/HackGenNerd
" atpull"%atclone"
zinit light yuru7/HackGen

# vim-plug
zinit ice cloneonly cp"plug.vim -> $HOME/.local/share/nvim/site/autoload/plug.vim" as"null"
zinit light junegunn/vim-plug

# choosenim
zinit ice as"program" from"gh-r" bpick"*$ENV_OS*_amd64"
zinit light dom96/choosenim

# cdx
zinit ice has"go" atclone"go install" atpull"%atclone" atload'eval "$(go-cdx --init)"' pick"/dev/null"
zinit light xztaityozx/go-cdx

# powerline-go
zinit ice has"go" atclone"go install" atpull"%atclone" atload"source $ZDOTDIR/powerline.zsh" pick"/dev/null"
zinit light justjanne/powerline-go

# tilix-theme
zinit ice has"tilix" cloneonly atclone"mkdir -p $ENV_DOT_CONFIG/tilix/schemes; cp ./*/*.json $ENV_DOT_CONFIG/tilix/schemes" pick"/dev/null"
zinit light storm119/Tilix-Themes

# exa
zinit ice from"gh-r" as"program" bpick"*$ENV_OS*" cp"exa* -> exa"  atclone" \
  curl -fLo $ZDOTDIR/.zinit/completions/_exa https://raw.githubusercontent.com/ogham/exa/master/contrib/completions.zsh" \
  atpull"%atclone"
zinit light ogham/exa

# ghq
zinit ice has"go" atclone"go install" atpull'%atclone' pick"/dev/null"
zinit light x-motemen/ghq

# pynvim
zinit ice has"pip3" atclone"pip3 install ." atpull"%atclone" pick"/dev/null"
zinit light neovim/pynvim

# neovim
zinit ice from"gh-r" bpick"*$ENV_OS*" as"command" pick"./*/bin/nvim"
zinit light neovim/neovim

# hub
zinit ice from"gh-r" atclone"tar xzf *.tgz && cp ./*/*/hub ./hub && rm -rf hub-*" \
  bpick"*$ENV_OS*" pick"./*/*/hub" cp"./*/etc/hub.zsh_completion -> $ZDOTDIR/.zinit/completions/_hub" \
  as"program" \
  atpull"%atclone"
zinit light github/hub

# bat
zinit ice from"gh-r" bpick"*x86_64*$ENV_OS*" as"program" pick"./*/bat"
zinit light sharkdp/bat

# gibo
zinit ice pick"gibo" atclone"chmod +x gibo && gibo update" atpull"%atclone" as"program"
zinit light simonwhitaker/gibo

# rg
zinit ice pick"*/rg" from"gh-r" as"program"
zinit light BurntSushi/ripgrep

# delta
zinit ice from"gh-r" as"program" pick"*/delta"
zinit light dandavison/delta

# fd
zinit ice from"gh-r" as"program" pick"*/fd"
zinit light sharkdp/fd

# trigger
zinit ice has"inotifywait" as"program" pick"*/trigger"
zinit light sharkdp/trigger

# tiep
zinit ice from"gh-r" as"program" bpick"*.tar.gz" pick"bin/teip"
zinit light greymd/teip

# yq
zinit ice cloneonly has"pip3" atclone"pip3 install ." atpull"%atclone" 
zinit light kislyuk/yq

# trdsql
zinit ice from"gh-r" as"program" pick"./*/trdsql"
zinit light noborus/trdsql

# lltsv
# 更新されてないし後で自作してもいいかなあ
zinit ice has"go" as"program" atclone"go install" atpull"%atclone"
zinit light sonots/lltsv

# googler
zinit ice as"program" pick"$ZPFX/bin/googler" make"install PREFIX=$ZPFX"
zinit light jarun/googler

# lazygit
zinit ice as"program" from"gh-r"
zinit light jesseduffield/lazygit

# grex
zinit ice from"gh-r" as"program"
zinit light pemistahl/grex

# ocs
zinit ice from"gh-r" as"program" pick"*/ocs"
zinit light xztaityozx/ocs

# zsh-utils
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
#zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions

# enable completions
autoload -U compinit && compinit

# load
ls $ZDOTDIR/*.zsh | while read L; do source $L; done

