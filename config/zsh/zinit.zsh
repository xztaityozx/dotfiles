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
