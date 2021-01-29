# zinit

[[ -f "$ZDOTDIR/.zinit/zinit.zsh" ]] && source "$ZDOTDIR/.zinit/zinit.zsh"
[[ -f "$ZDOTDIR/.zinit/bin/zinit.zsh" ]] && source "$ZDOTDIR/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

type zinit &> /dev/null && {
  mkdir -p $ZPFX/{bin,man/man1,share}
}

# プロンプトが出る前にロードして欲しいツール
# {{{

  function _zinit_bat_atload() {
    export MANPAGER="sh -c 'col -xb | bat --theme TwoDark -l man -p'"
    alias cat="bat --theme TwoDark"
    unfunction $0
  }

  zinit as"program" from"gh-r" for \
    pick"./*/bin/nvim"                                                                 neovim/neovim \
    pick"./*/bat"      cp"./*/autocomplete/bat.zsh -> _bat" atload"_zinit_bat_atload"  @sharkdp/bat \
    pick"*/fd"                                                                         @sharkdp/fd \
    pick"*/go-cdx"     atload"eval '$(go-cdx --init)'"                                 xztaityozx/go-cdx \
                       atload"alias lg=lazygit"                                        jesseduffield/lazygit

  # powerline
  # {{{
  
    zinit ice as"program" nocompletions from"gh-r" pick"powerline-go" cp"powerline-go* -> powerline-go" nocompile atload"source $ZDOTDIR/powerline.zsh"
    zinit load justjanne/powerline-go
  
  # }}}

  # fzf
  # {{{

    function _zinit_fzf_atload() {
      export FZF_DEFAULT_OPTS="-1 -0 --cycle --reverse --height=40% --border"
      export FZF_DEFAULT_COMMAND="fd --type=f --exclude .git --hidden --follow"
      export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
      unfunction $0
    }

    zinit ice as"program" \
      pick"$ZPFX/bin/fzf" \
      atclone"cp -vf bin/fzf $ZPFX/bin/; cp -vf man/man1/fzf $ZPFX/man/man1" \
      atpull"%atclone" \
      atload"_zinit_fzf_atload" \
      make"!PREFIX=$ZPFX install"
    zinit load junegunn/fzf

  # }}}

  # anyenv
  # {{{

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

  # }}}

  # exa
  # {{{

    function _zinit_exa_atload() {
      alias ls="exa --git"
      unfunction $0
    }

    zinit ice wait lucid from"gh-r" as"program" bpick"*$ENV_OS*" cp"exa* -> exa"  atclone" \
      curl -fLo $ZDOTDIR/.zinit/completions/_exa https://raw.githubusercontent.com/ogham/exa/master/contrib/completions.zsh" \
      atpull"%atclone" \
      atload"_zinit_exa_atload"
    zinit light ogham/exa

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

  zinit wait"1" lucid as"program" from"gh-r" for \
    pick"jq"                cp"jq-* -> jq"   nocompile  stedolan/jq \
    pick"uni"               cp"uni-* -> uni" nocompile  arp242/uni \
    pick"$ZPFX/bin/googler" make"install PREFIX=$ZPFX"  jarun/googler \
    pick"*/ocs"                                         xztaityozx/ocs \
    pick"*/bin/gh"                                      cli/cli \
    pick"*/ghq"             cp"*/misc/zsh/_ghq -> _ghq" x-motemen/ghq \
                                                        pemistahl/grex \
                                                        tomnomnom/gron \
                                                        dom96/choosenim

  zinit wait"1" lucid as"program" for \
    pick"gibo"                             atclone"chmod +x gibo && gibo update"         atpull"%atclone"  simonwhitaker/gibo \
    pick"cht.sh" cp"share/zsh.txt -> _cht" atclone"curl https://cht.sh/:cht.sh > cht.sh" atpull"%atclone"  chubin/cheat.sh


# }}}

# cloneonlyないつまでもロードできなくていいやつ
# {{{

  # フォント系
  # {{{

    zinit wait"3" lucid as"null" from"gh-r" cloneonly nocompile for \
      cp"./*.ttf -> $ENV_FONT_DIR/Cica"                      bpick"*_with_emoji.zip"  miiton/Cica \
      cp"./HackGenNerd_*/*.ttf -> $ENV_FONT_DIR/HackGenNerd" bpick"*Nerd*"            yuru7/HackGen

  # }}}

    zinit wait"3" lucid as"null" cloneonly nocompile for \
      cp"plug.vim -> $HOME/.local/share/nvim/site/autoload/plug.vim"     junegunn/vim-plug \
      has"tilix" cp"./*/*.json -> $ENV_DOT_CONFIG/tilix/schemes"         storm119/Tilix-Themes 


  # pip3 install
  # {{{

    zinit wait"3" lucid has"pip3" nocompile as"null" cloneonly atclone"pip3 install ." atpull"%atclone" for \
      atdelete"pip3 uninstall -y pynvim" neovim/pynvim \
      atdelete"pip3 uninstall -y httpie" httpie/httpie \
      atdelete"pip3 uninstall -y bpytop" aristocratos/bpytop

  # }}}

  # tmux plugins
  # {{{

    zinit ice wait lucid has"tmux" as"null" \
      atclone'sed -i "s@DEFAULT_TPM_PATH=.*\$@DEFAULT_TPM_PATH=\"${TPM_ROOT:-$HOME/.tmux/plugins/}\"@" $PWD/scripts/variables.sh' atpull'%atload' \
      atload'export TPM_ROOT="$PWD"'
    zinit light tmux-plugins/tpm

  # }}}

# }}}

# zsh-utils
zinit for \
  light-mode zsh-users/zsh-autosuggestions \
  light-mode zdharma/fast-syntax-highlighting
zinit wait lucid for \
  light-mode atload'zicompinit;zicdreplay' blockf zsh-users/zsh-completions
