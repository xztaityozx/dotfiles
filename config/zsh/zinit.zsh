# zinit

type zip tar curl wget git unzip &> /dev/null || return 127;

[[ -f "$ZDOTDIR/.zinit/zinit.zsh" ]] && source "$ZDOTDIR/.zinit/zinit.zsh"
[[ -f "$ZDOTDIR/.zinit/bin/zinit.zsh" ]] && source "$ZDOTDIR/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

type zinit &> /dev/null && {
  mkdir -p $ZPFX/{bin,man/man1,share,script}
}

# zinitに構文追加したりするやつ
# {{{

  zinit light NICHOLAS85/z-a-eval
  zinit light NICHOLAS85/z-a-linkbin
  zinit light zdharma-continuum/zinit-annex-bin-gem-node

# }}}

# 言語とかのruntime系
# {{{

  # anyenv
  # {{{
    # anyenvのzshを起動するたびに実行する部分
    function _zinit_anyenv_atload() {
      add-zsh-hook precmd __hook-anyenv-post-install-env
      unfunction $0
    }

    # anyenv install した後initスクリプトを更新するHook
    function __hook-anyenv-post-install-env() {
      [[ "${1}" =~ "anyenv install" ]] && zinit recache anyenv/anyenv
      true
    }

    zinit ice as"program" pick"bin/anyenv" atclone"yes | bin/anyenv install --init" eval"bin/anyenv init - zsh" \
      atload'export ANYENV_ROOT=$PWD;_zinit_anyenv_atload' \
      atpull"anyenv install --update"
    zinit light anyenv/anyenv

    zinit ice wait'[[ -n "$(type anyenv)" ]]' has"anyenv" cloneonly nocompile \
      atclone"mkdir -p $(anyenv root)/plugins/anyenv-update && cp -r * $(anyenv root)/plugins/anyenv-update" \
      atpull"%atclone"
    zinit light znz/anyenv-update

    # anyenvでなんもインストールされてなかったらセットアップ開始する
    [[ -z "$(anyenv versions 2>&1)" ]] && {
        VERSIONS="
goenv 
plenv 
pyenv 
nodenv
tfenv
rbenv"

      echo "$VERSIONS" | while read L; do anyenv install "$L" --skip-existing ; done

        zinit recache anyenv/anyenv
        source "$(anyenv root)/evalcache.zsh"

        zinit ice has"nodenv" cloneonly nocompile \
          atclone'mkdir -p $(nodenv root)/plugins/nodenv-yarn-install && cp -r * $(nodenv root)/plugins/nodenv-yarn-install/' \
          atpull"%atclone"
        zinit light pine/nodenv-yarn-install

        PYENV_GLOBAL_VERSION=3.10.4
        pyenv install "$PYENV_GLOBAL_VERSION"
        pyenv global "$PYENV_GLOBAL_VERSION"

        goenv install 1.16.5 --skip-existing
        goenv install 1.18.0 --skip-existing
        goenv global 1.18.0

        nodenv install 16.8.0 --skip-existing
        nodenv global 16.8.0

        rbenv install 3.1.1
    }
  # }}}
  
  # rust
  #{{{
    zinit light zdharma-continuum/zinit-annex-rust

    zinit id-as"rust" wait=1 as=null sbin"bin/*" lucid rustup \
      atload"[[ ! -f ${ZINIT[COMPLETIONS_DIR]}/_cargo ]] && zinit creinstall rust; export CARGO_HOME=\$PWD RUSTUP_HOME=\$PWD/rustup" for \
        zdharma-continuum/null
  #}}}

# }}}


function is_x86_64() {
  [[ "$(uname -m)" == "x86_64" ]]
}

function zinit-creinstall-once() {
  local CMD_NAME="${1}"
  local FULL_NAME="${2:-$CMD_NAME}"
  [[ -z "$CMD_NAME" ]] && {echo plugin is not specified; return 1}
  [[ ! -f "$ZINIT[COMPLETIONS_DIR]/_${1}" ]] && zinit creinstall "$FULL_NAME"
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

  # x86系のバイナリしかないやつ


  # x86にはバイナリがある場合
  zinit if'is_x86_64' as"program" from"gh-r" for \
    pick"*/fd"                                                                        @sharkdp/fd \
    pick"./*/bat"  mv"./**/completions/bat.zsh.in -> _bat" atload"_zinit_bat_atload"  @sharkdp/bat

  # x86系のバイナリが配布されてないので、自前でビルドするやつ
  zinit if'[[ ! is_x86_64 ]]' rustup for \
    id-as'bat' cargo'!bat' atload"_zinit_bat_atload" zdharma-continuum/null \
    id-as'fd'  cargo'fd-find <- !fd-find -> fd' atclone"zinit-creinstall-once fd" zdharma-continuum/null

  zinit if'[[ ! is_x86_64 ]]' has"go" atclone"go build" eval'go-cdx --init' lbin'!go-cdx' for xztaityozx/go-cdx
  zinit if'is_x86_64' eval'go-cdx --init' lbin'!go-cdx' for xztaityozx/go-cdx

  # aarchなバイナリも配ってくれてるツール群
  zinit from"gh-r" for \
    lbin'!zoxide'  eval"zoxide init zsh" atload'export _ZO_DATA_DIR="$PWD/.local/share/"' ajeetdsouza/zoxide \
    lbin'!lazygit' atload"alias lg='lazygit -ucd $HOME/.config/lazygit'"                  jesseduffield/lazygit \
    lbin'!direnv.* -> direnv' eval'direnv hook zsh' direnv/direnv

  # nvim
  # zinitにrelaeseの名前を解決させることができないのでなんとかする
  zinit ice from"gh-r" ver"stable" bpick"nvim-$ENV_OS*.tar.gz" lbin'!./*/bin/nvim -> nvim'
  zinit light neovim/neovim

  # }}}

  # fzf
  # fzfは補完とかを提供してくれるスクリプトがReleaseのアーカイブに含まれてないのでビルド
  # {{{

    function _zinit_fzf_atload() {
      export FZF_DEFAULT_OPTS="-1 -0 --cycle --reverse --height=40% --border"
      export FZF_DEFAULT_COMMAND="fd --type=f --exclude .git --hidden --follow"
      export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
      unfunction $0
    }

    function _fzf_compgen_path() {
      fd --type=f --exclude .git --hidden --follow
    }
    
    function _fzf_compgen_dir() {
      fd --type=f --exclude .git --hidden --follow
    }

    # fzf本体はmakeでインストールされるけど、fzf-tmuxはされないのでlbinでsoft link貼る
    zinit has"go" atload"_zinit_fzf_atload" \
      lbin'!bin/fzf-tmux -> fzf-tmux' \
      make'!install PREFIX=$ZPFX' eval'cat shell/*.zsh' \
        for junegunn/fzf

  # }}}

  # exa
  # {{{

    function _zinit_exa_atload() {
      alias ls="exa --git"
      alias ll="exa --time-style=long-iso -mUuhla --icons --changed --git"
      unfunction $0
    }

    zinit ice wait lucid from"gh-r" as"program" bpick"*$ENV_OS*" cp"exa* -> ./bin/exa" pick"bin/exa"  atclone"cp ./completions/exa.zsh $ZDOTDIR/.zinit/completions/_exa" \
      atpull"%atclone" \
      atload"_zinit_exa_atload"
    zinit light ogham/exa

  # }}}
  
  # powerline-go
  # リリースに最新のものがアップロードされないので自前でビルド
  # {{{
  
    zinit has"go" lbin'!powerline-go' nocompletions nocompile \
      atclone"go build" atpull"%atclone" \
      atload"source $ZDOTDIR/powerline.zsh" \
        for justjanne/powerline-go

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

  # rb
  zinit ice wait"1" lucid as"program" pick"bin/rb" atclone"mkdir bin; mv rb bin/rb" 
  zinit light thisredone/rb

  # align
  zinit ice wait"1" lucid has"go" as"program" atclone"go get; go build -o $ZPFX/bin/align" atpull"%atclone" pick"$ZPFX/bin/align"
  zinit light jiro4989/align

  zinit wait"1" lucid as"program" from"gh-r" for \
    pick"jq"                cp"jq-* -> jq"   nocompile           stedolan/jq \
    pick"uni"               cp"uni-* -> uni" nocompile           arp242/uni \
    pick"*/bin/gh"                                               cli/cli \
    pick"*/ghq"             cp"*/misc/zsh/_ghq -> _ghq"          x-motemen/ghq \
    pick"$ZPFX/bin/hexyl"   cp"hexyl-*/hexyl -> $ZPFX/bin/hexyl" @sharkdp/hexyl \
    pick"$ZPFX/bin/pastel" atload"export COLORTERM=24bit"  cp"pastel-*/pastel -> $ZPFX/bin/pastel" @sharkdp/pastel \
                                                                 pemistahl/grex \
                                                                 tomnomnom/gron \
                                                                 dom96/choosenim \
    pick"$ZPFX/bin/sad" cp"sad -> $ZPFX/bin/sad" atload"alias sad='sad --fzf=\"--height=100%\"'"                ms-jpq/sad \
    pick"$ZPFX/bin/sd"  cp"sd* -> $ZPFX/bin/sd" atload"alias sd='sd -p'"                 chmln/sd \

  zinit ice has"dotnet" wait"1" lucid as"program" atclone"make;make install"
  zinit light xztaityozx/ocs

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
      atinit"mkdir -p $HOME/.local/share/nvim/site/pack/packer/start/" cp"* -> $HOME/.local/share/nvim/site/pack/packer/start/" wbthomason/packer.nvim \
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
