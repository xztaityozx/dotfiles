# zinit

type zip tar curl wget git unzip &> /dev/null || return 127;

[[ -f "$ZDOTDIR/.zinit/zinit.zsh" ]] && source "$ZDOTDIR/.zinit/zinit.zsh"
[[ -f "$ZDOTDIR/.zinit/bin/zinit.zsh" ]] && source "$ZDOTDIR/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

type zinit &> /dev/null && {
  mkdir -p $ZPFX/{bin,man/man1,share,script}
}

# プロンプトが出る前にロードして欲しいツール
# {{{

  function _zinit_bat_atload() {
    export MANPAGER="sh -c 'col -xb | bat --theme TwoDark -l man -p'"
    alias cat="bat --theme TwoDark"
    unfunction $0
  }

  function _zinit_go-cdx_atclone() {
    go-cdx --init > $ZPFX/script/go-cdx-rc.zsh
    unfunction $0
  }

  zinit as"program" from"gh-r" for \
    pick"./*/bin/nvim"                                                                       neovim/neovim \
    pick"./*/bat"      mv"./*/autocomplete/bat.zsh -> _bat" atload"_zinit_bat_atload"    @sharkdp/bat \
    pick"*/fd"                                                                         @sharkdp/fd \
    pick"*/go-cdx"     atload'source $ZPFX/script/go-cdx-rc.zsh' atclone"_zinit_go-cdx_atclone" atpull"%atclone"                                xztaityozx/go-cdx \
    pick"lazygit"    atload"alias lg='lazygit -ucd $HOME/.config/lazygit'"           jesseduffield/lazygit
  
  # }}}

  # fzf
  # {{{

    function _zinit_fzf_atload() {
      export FZF_DEFAULT_OPTS="-1 -0 --cycle --reverse --height=40% --border"
      export FZF_DEFAULT_COMMAND="fd --type=f --exclude .git --hidden --follow"
      export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
      unfunction $0
    }

    zinit ice has"go" as"program" \
      pick"$ZPFX/bin/fzf" \
      atclone"cp -vf bin/fzf $ZPFX/bin/; cp -vf man/man1/fzf $ZPFX/man/man1" \
      atpull"%atclone" \
      atload"_zinit_fzf_atload" \
      make"!install"
    zinit load junegunn/fzf

  # }}}
  
  # {{{
  # dienv

    function _zinit_direnv_atload() {
      [[ -f "$ZPFX/script/direnv-rc.zsh" ]] || direnv hook zsh > $ZPFX/script/direnv-rc.zsh

      source $ZPFX/script/direnv-rc.zsh
      unfunction $0
    }

    zinit ice from"gh-r" as"program" cp"direnv.* -> $ZPFX/bin/direnv" pick"$ZPFX/bin/direnv" atload'_zinit_direnv_atload'
    zinit light direnv/direnv
  
  # }}}

  # anyenv
  # {{{
 
    # anyenvの初回/更新後セットアップ
    function _zinit_anyenv_atclone() {
      anyenv install --init &> /dev/null
      
      eval "$(anyenv init - zsh)"

      zinit ice has"anyenv" cloneonly nocompile \
        atclone"mkdir -p $(anyenv root)/plugins/anyenv-update && cp -r * $(anyenv root)/plugins/anyenv-update" \
        atpull"%atclone"
      zinit light znz/anyenv-update

      declare -A versions=(
        "goenv" "1.16.5"
        "plenv" "5.32.0"
        "pyenv" "3.9.0"
        "nodenv" "16.8.0"
      )

      for key in ${(k)versions}; do
        anyenv install --skip-existing $key
      done

      zinit ice has"plenv" cloneonly nocompile \
        atclone"mkdir -p $(plenv root)/plugins/perl-download && cp -r * $(plenv root)/plugins/perl-download" \
        atpull"%atclone"
      zinit light skaji/plenv-download
      
      for key in ${(k)versions}; do
        $key install ${versions[$key]} --skip-existing 
        $key global ${versions[$key]}
      done
    }

    # anyenvのzshを起動するたびに実行する部分
    function _zinit_anyenv_atload() {
      [[ -e "$ZPFX/script/anyenv-rc.zsh" ]] && source "$ZPFX/script/anyenv-rc.zsh"
      unfunction $0
      unfunction _zinit_anyenv_atclone
      add-zsh-hook zshaddhistory __hook-anyenv-post-install-env
    }

    # anyenv install した後initスクリプトを更新するHook
    function __hook-anyenv-post-install-env() {
      [[ "${1}" =~ "anyenv install" ]] && anyenv init --no-rehash - zsh > $ZPFX/script/anyenv-rc.zsh
      true
    }

    zinit ice wait lucid as"program" pick"bin/anyenv" \
      atload'export ANYENV_ROOT=$PWD;_zinit_anyenv_atload' \
      atclone"_zinit_anyenv_atclone" atpull"anyenv install --update;%atclone"
    zinit light anyenv/anyenv

  # }}}

  # exa
  # {{{

    function _zinit_exa_atload() {
      alias ls="exa --git"
      alias ll="exa --time-style=long-iso -mUuhla --icons --changed --git"
      unfunction $0
    }

    zinit ice wait lucid from"gh-r" as"program" bpick"*$ENV_OS*" cp"exa* -> ./bin/exa" pick"bin/exa"  atclone" \
      curl -fLo $ZDOTDIR/.zinit/completions/_exa https://raw.githubusercontent.com/ogham/exa/master/contrib/completions.zsh" \
      atpull"%atclone" \
      atload"_zinit_exa_atload"
    zinit light ogham/exa

  # }}}
  
  # starship
  # {{{ 
  
  #function _zinit_starship_atload() {
    #[[ -e "$ZPFX/script/starship-init.zsh" ]] && source "$ZPFX/script/starship-init.zsh"
    #export STARSHIP_CONFIG="$DOTFILES_PATH/config/starship/starship.toml"
    #unfunction $0
  #}

  #zinit ice from"gh-r" as"program" cp"starship -> $ZPFX/bin/starship" pick"$ZPFX/bin/starship" atclone"starship init zsh --print-full-init > $ZPFX/script/starship-init.zsh" atpull"%atclone" atload"_zinit_starship_atload"
  #zinit light starship/starship

  # }}}

  # powerline
  # {{{
  
    zinit ice has"go" as"program" pick"$GOPATH/bin/powerline-go" nocompletions nocompile atclone"go install" atpull"%atclone" atload"source $ZDOTDIR/powerline.zsh"
    zinit load justjanne/powerline-go

  # }}}
# }}}

# プロンプトが出てから0秒後にロードして欲しいツール
# {{{

  function _zinit_csvq_atload() {
    alias ltsvq="csvq -i LTSV"
    unfunction $0
  }

  zinit wait lucid as"program" from"gh-r" for \
    pick"*/rg"                                          BurntSushi/ripgrep \
    pick"*/delta"                                       dandavison/delta \
    bpick"*.tar.gz" pick"bin/teip"                      greymd/teip \
    pick"*/sel"     cp"*/sel-completion.zsh -> _sel"    xztaityozx/sel \
    pick"*/csvq"    atload"_zinit_csvq_atload"          mithrandie/csvq \
                                                        lotabout/rargs

  # hub
  # {{{

    zinit ice lucid wait from"gh-r" atclone"tar xzf *.tgz && cp ./*/*/hub ./hub && rm -rf hub-*" \
      bpick"*$ENV_OS*" pick"./*/*/hub" cp"./*/etc/hub.zsh_completion -> $ZINIT[COMPLETIONS_DIR]/_hub" \
      as"program" \
      atpull"%atclone"
    zinit light github/hub

  # }}}

# }}}

# そんなに急いでロードしなくていいツール
# {{{

  # image2ascii
  zinit ice wait"1" lucid has"go" as"program" atclone"go get; go build -o $ZPFX/bin/image2ascii" atpull"%atclone" pick"$ZPFX/bin/image2ascii"
  zinit light qeesung/image2ascii

  # align
  zinit ice wait"1" lucid has"go" as"program" atclone"go get; go build -o $ZPFX/bin/align" atpull"%atclone" pick"$ZPFX/bin/align"
  zinit light jiro4989/align

  zinit wait"1" lucid as"program" from"gh-r" for \
    pick"jq"                cp"jq-* -> jq"   nocompile           stedolan/jq \
    pick"uni"               cp"uni-* -> uni" nocompile           arp242/uni \
    pick"*/ocs"                                                  xztaityozx/ocs \
    pick"*/bin/gh"                                               cli/cli \
    pick"*/ghq"             cp"*/misc/zsh/_ghq -> _ghq"          x-motemen/ghq \
    pick"$ZPFX/bin/hexyl"   cp"hexyl-*/hexyl -> $ZPFX/bin/hexyl" @sharkdp/hexyl \
    pick"$ZPFX/bin/pastel" atload"export COLORTERM=24bit"  cp"pastel-*/pastel -> $ZPFX/bin/pastel" @sharkdp/pastel \
                                                                 pemistahl/grex \
                                                                 tomnomnom/gron \
                                                                 dom96/choosenim \
    pick"$ZPFX/bin/sad" cp"sad -> $ZPFX/bin/sad" atload"alias sad='sad --fzf=\"--height=100%\"'"                ms-jpq/sad \
    pick"$ZPFX/bin/sd"  cp"sd* -> $ZPFX/bin/sd" atload"alias sd='sd -p'"                 chmln/sd


  zinit wait"1" lucid as"program" for \
    pick"gibo"                             atclone"chmod +x gibo && gibo update"         atpull"%atclone"  simonwhitaker/gibo \
    pick"bin/xpanes"                                                                                       greymd/tmux-xpanes \
    pick"cht.sh" cp"share/zsh.txt -> _cht" atclone"curl https://cht.sh/:cht.sh > cht.sh" atpull"%atclone"  chubin/cheat.sh

  zinit wait"1" lucid as"program" cloneonly for \
    pick"$ZPFX/bin/googler" make"install PREFIX=$ZPFX"  jarun/googler

# }}}

# cloneonlyないつまでもロードできなくていいやつ
# {{{

  # フォント系
  # {{{

    zinit lucid as"null" from"gh-r" cloneonly nocompile for \
      cp"./*.ttf -> $ENV_FONT_DIR/Cica"                      bpick"*_with_emoji.zip"  miiton/Cica \
      cp"./HackGenNerd_*/*.ttf -> $ENV_FONT_DIR/HackGenNerd" bpick"*Nerd*"            yuru7/HackGen

  # }}}

    zinit lucid as"null" cloneonly nocompile for \
      atinit"mkdir -p $HOME/.local/share/nvim/site/autoload" cp"plug.vim -> $HOME/.local/share/nvim/site/autoload/plug.vim"     junegunn/vim-plug \
      has"tilix" cp"./*/*.json -> $ENV_DOT_CONFIG/tilix/schemes"         storm119/Tilix-Themes 

    zinit wait"3" lucid as"program" from"gh-r" for \
      cp"*/hyperfine -> $ZPFX/bin/hyperfine" pick"$ZPFX/bin/hyperfine" @sharkdp/hyperfine

  # pip3 install
  # {{{

    zinit lucid has"pip3" nocompile as"null" cloneonly atclone"pip3 install ." atpull"%atclone" for \
      atdelete"pip3 uninstall -y pynvim" neovim/pynvim \
      atdelete"pip3 uninstall -y httpie" httpie/httpie \
      atdelete"pip3 uninstall -y bpytop" aristocratos/bpytop \
      atdelete"pip3 uninstall -y tqdm"   tqdm/tqdm

  # }}}
  
  # tmux plugins
  # {{{
    
    zinit lucid has"tmux" nocompile as"null" cloneonly atclone"mkdir -p $DOTFILES_PATH/config/tmux/plugins/" atpull"%atclone" for \
      cp"prefix_highlight.tmux -> $DOTFILES_PATH/config/tmux/plugins/" tmux-plugins/tmux-prefix-highlight
  # }}}


# }}}

# zsh-utils
function _zinit_zsh-history-substring-search_atload() {
  bindkey "^[[A" history-substring-search-up
  bindkey "^[[B" history-substring-search-down
  unfunction $0
}

zinit wait lucid for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" zdharma-continuum/fast-syntax-highlighting \
  blockf zsh-users/zsh-completions \
  atload"!_zsh_autosuggest_start" zsh-users/zsh-autosuggestions \
  atload'_zinit_zsh-history-substring-search_atload' zsh-users/zsh-history-substring-search
