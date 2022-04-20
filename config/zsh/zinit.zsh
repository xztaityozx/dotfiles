# zinit

type zip tar curl wget git unzip &> /dev/null || return 127;

[[ -f "$ZDOTDIR/.zinit/bin/zinit.zsh" ]] && source "$ZDOTDIR/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

type zinit &> /dev/null && {
  mkdir -p $ZPFX/{bin,man/man1,share,script}
}

# zinitに構文追加したりするやつ
# {{{

  zinit atinit'Z_A_USECOMP=1' light-mode for NICHOLAS85/z-a-eval
  zinit light NICHOLAS85/z-a-linkbin
  zinit light zdharma-continuum/zinit-annex-bin-gem-node
  zinit light zdharma-continuum/zinit-annex-rust

# }}}

# 言語とかのruntime系
# {{{

  # anyenv
  # {{{
    # anyenvのzshを起動するたびに実行する部分
    function _zinit_anyenv_atload() {

      add-zsh-hook -L precmd | grep __hook-anyenv-post-install-env &>/dev/null || {
        add-zsh-hook precmd __hook-anyenv-post-install-env
      }
      unfunction $0
    }

    # anyenv install した後initスクリプトを更新するHook
    function __hook-anyenv-post-install-env() {
      [[ "${1}" =~ "anyenv install" ]] && zinit recache anyenv/anyenv
      true
    }

    zinit ice pick'bin/anyenv' as"program" atclone"yes | bin/anyenv install --init" eval"bin/anyenv init --no-rehash - zsh | sed 's@goenv rehash --only-manage-paths@#&@'" \
      atload'export ANYENV_ROOT=$PWD;_zinit_anyenv_atload' \
      atpull"anyenv install --update"
    zinit light anyenv/anyenv

    zinit ice wait'[[ -n "$(type anyenv)" ]]' lucid has"anyenv" cloneonly nocompile \
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
rbenv
tfenv"

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
        rbenv global 3.1.1
    }
  # }}}
  
  # rust
  #{{{

    zinit id-as"rust" as=null sbin"bin/*" lucid rustup \
      atload"[[ ! -f ${ZINIT[COMPLETIONS_DIR]}/_cargo ]] && zinit creinstall -Q rust; export CARGO_HOME=\$PWD RUSTUP_HOME=\$PWD/rustup" for \
        xztaityozx/null
  #}}}

# }}}


function is_x86_64() {
  [[ -z "$IS_X86_64_CACHE" ]] && {
    [[ "$(uname -m)" == "x86_64" ]]
    IS_X86_64_CACHE=$?
  }

  [[ "$IS_X86_64_CACHE" == 0 ]] && true
  false
}

function is_not_x86_64() {
  [[ -z "$IS_X86_64_CACHE" ]] && {
    [[ "$(uname -m)" == "x86_64" ]]
    IS_X86_64_CACHE=$?
  }

  [[ "$IS_X86_64_CACHE" == 0 ]] && false
  true
}

function zinit-creinstall-once() {
  local CMD_NAME="${1}"
  local FULL_NAME="${2:-$CMD_NAME}"
  [[ -z "$CMD_NAME" ]] && {echo plugin is not specified; return 1}
  [[ ! -f "$ZINIT[COMPLETIONS_DIR]/_${1}" ]] && zinit creinstall "$FULL_NAME"
}

function zinit-rust-ready() {
  [[ -v CARGO_HOME ]] && [[ -v RUSTUP_HOME ]]
}

# プロンプトが出る前にロードして欲しいツール
# {{{

  function _zinit_bat_atload() {
    export MANPAGER="sh -c 'col -xb | bat --theme TwoDark -l man -p'"
    alias cat="bat --theme TwoDark"
    unfunction $0
  }


  # x86にはバイナリがある場合
  zinit if'is_x86_64' light-mode nocompile from"gh-r" for \
    lbin'!*/fd -> fd'                                                                         @sharkdp/fd \
    lbin'!./*/bat -> bat'  mv"./*/autocomplete/bat.zsh -> _bat" atload"_zinit_bat_atload"     @sharkdp/bat

  # aarchは配布されてないので、自前でビルドするやつ
  zinit if'is_not_x86_64' light-mode nocompile rustup wait'zinit-rust-ready' lucid for \
    id-as'bat' cargo'!bat' atload"_zinit_bat_atload" xztaityozx/null \
    id-as'fd'  cargo'fd <- !fd-find -> fd' atclone"zinit-creinstall-once fd" xztaityozx/null

  zinit if'is_not_x86_64' has"go" light-mode atclone"go build" eval'./go-cdx --init' lbin'!go-cdx' for xztaityozx/go-cdx
  zinit if'is_x86_64' from"gh-r" light-mode eval'linux/go-cdx --init' lbin'!linux/go-cdx -> go-cdx' for xztaityozx/go-cdx

  # aarchなバイナリも配ってくれてるツール群
  zinit from"gh-r" light-mode nocompile for \
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

    # fzf
    zinit atload"_zinit_fzf_atload" light-mode nocompile \
      cloneopts"--depth 1" \
      lbin'!bin/{fzf,fzf-tmux}' \
      atclone"./install --bin --no-{zsh,bash,fish,completion,key-bindings}" atpull"%atclone" \
      eval'cat shell/*.zsh' \
        for junegunn/fzf

  # }}}
  
  # powerline-go
  # リリースに最新のものがアップロードされないので自前でビルド
  # as"null" をつけないと謎のpreviewスクリプトが暴走してえらいことになる
  # {{{
  
    zinit has"go" lbin'!powerline-go' light-mode nocompletions nocompile as"null" \
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
  function _zinit_exa_atload() {
    alias ls="exa --git"
    alias ll="exa --time-style=long-iso -mUuhla --icons --changed --git"
    unfunction $0
  }
  function _zinit_pastel_atload() {
    export COLORTERM=24bit
    unfunction $0
  }


  # x86_64向けにしかバイナリがないので、自前でビルドしたりダウンロードしたりする
  # {{{

    zinit if'is_x86_64' wait light-mode nocompile lucid from"gh-r" for \
      lbin'!*/rg -> rg' \
        atload'zinit-creinstall-once rg BurntSushi/ripgrep' BurntSushi/ripgrep \
      lbin'!*/delta -> delta' dandavison/delta \
      bpick'*.tar.gz' lbin'!bin/teip -> teip' \
        atload'zinit-creinstall-once teip greymd/teip' greymd/teip \
      lbin'!*/sel -> sel' cp'*/sel-completion.zsh -> _sel' \
        atload'zinit-creinstall-once sel xztaityozx/sel' xztaityozx/sel \
      lbin'!rargs' lotabout/rargs \
      lbin'!bin/exa -> exa' cp"completions/exa.zsh -> _exa" \
        atload"_zinit_exa_atload" \
          ogham/exa

    zinit if'is_not_x86_64' light-mode wait'zinit-rust-ready' nocompile lucid rustup for \
      id-as'ripgrep' cargo'rg <- !ripgrep -> rg'                       xztaityozx/null \
      id-as'delta'   cargo'delta <- !git-delta -> delta'               xztaityozx/null \
      id-as'teip'    cargo'!teip'                                      xztaityozx/null \
      id-as'rargs'   cargo'!rargs'                                     xztaityozx/null \
      id-as'hexyl'   cargo'!hexyl'                                     xztaityozx/null \
      id-as'pastel'  cargo'!pastel' atload'_zinit_pastel_atload'       xztaityozx/null \
      id-as'grex'    cargo'!grex'                                      xztaityozx/null \
      id-as'hyperfine'    cargo'!hyperfine'                            xztaityozx/null \

    # cargo install exaだとビルド失敗するので、HEADでビルド
    zinit if'is_not_x86_64' light-mode wait'zinit-rust-ready' nocompile lucid \
      atload'zinit-creinstall-once exa ogham/exa;_zinit_exa_atload' \
      lbin'!target/release/exa' \
      atclone"cargo build --release" atpull'%atclone' for \
        ogham/exa


    zinit has"go" if'is_not_x86_64' light-mode wait lucid nocompile lucid atclone"go build" atpull"%atclone" for \
      lbin'!sel' atclone'go build && sel completion zsh > _sel' xztaityozx/sel

  # }}}
  #
  # x86_64向けにもarm向けにもバイナリを配ってくれているありがたいツール
  # {{{

    zinit wait nocompile light-mode lucid from"gh-r" for \
      lbin'!*/csvq -> csvq' atload'_zinit_csvq_atload' mithrandie/csvq

  # }}}

  # hub
  # Releaseに最新のバイナリをおいてないのでどっちにしろビルドしないといけない
  # {{{

    zinit has"go" light-mode nocompile lucid wait \
      cloneopts"--config transfer.fsckobjects=false --config receive.fsckobjects=false --config fetch.fsckobjects=false" \
      cp'etc/hub.zsh_completion -> _hub' \
      atclone"go build; zinit-creinstall-once hub github/hub" atpull"%atclone" \
      lbin'!hub' \
        for @github/hub

  # }}}

# }}}

# そんなに急いでロードしなくていいツール
# {{{

  zinit wait"1" light-mode nocompile lucid for \
    has"ruby" lbin'!rb' thisredone/rb

  # align
  zinit wait"1" nocompile lucid has"go" light-mode lbin'!align' atclone"go build" atpull"%atclone" for jiro4989/align

  # gh-rにバイナリがあるやつ
  zinit wait"1" light-mode nocompile lucid from"gh-r" for \
    lbin'!*/gojq' atload'alias jq=gojq' itchyny/gojq \
    lbin'!uni-* -> uni' arp242/uni \
    lbin'!*/bin/gh' if'is_x86_64' bpick'*.tar.gz' \
      atclone'*/bin/gh completion -s zsh > _gh' atpull'%atclone' atload'zinit-creinstall-once gh cli/cli' cli/cli \
    lbin'!*/ghq'       if'is_x86_64' atload'zinit-creinstall-once ghq x-motemen/ghq' x-motemen/ghq \
    lbin'!*/hexyl'     if'is_x86_64'                              @sharkdp/hexyl \
    lbin'!*/hyperfine' if'is_x86_64'                              @sharkdp/hyperfine \
    lbin'!*/pastel'    if'is_x86_64' atload'_zinit_pastel_atload' @sharkdp/pastel \
    lbin'!grex'        if'is_x86_64'                              pemistahl/grex \
    lbin'!gron'                                  tomnomnom/gron \
    lbin'!sad' atload"alias sad='sad --fzf=\"--height=100%\"'" ms-jpq/sad \
    lbin'!ocs' has"dotnet"                       xztaityozx/ocs

  # gh-rにx86_64系のバイナリしかないので自前でビルドしないとダメな奴
  # Go製のツール
  zinit if'is_not_x86_64' wait"1" light-mode lucid nocompile has"go" atpull'%atclone' for \
    make'!install prefix=$ZPFX' atclone'gh completion -s zsh > _gh' atload'zinit-creinstall-once gh cli/cli' cli/cli \
    make'!build' lbin'!ghq' atload'zinit-creinstall-once ghq x-motemen/ghq' x-motemen/ghq \
    atclone'go build' lbin'!gron' tomnomnom/gron

  # sdは最新のデフォルトブランチの内容がRelaeseにアップロードされていないので自前でビルド
  zinit wait"zinit-rust-ready" light-mode lucid rustup nocompile for \
    id-as'sd' cargo'sd' atload"alias sd='sd -p'" chmln/sd

  # gh-rにバイナリがあるのではなくcloneすれば実行可能ファイルが手に入る系
  zinit wait'1' nocompile light-mode lucid atpull'%atclone' for \
    lbin'!gibo' atclone'./gibo update; cp shell-completions/gibo-completion.zsh _gibo' atload'zinit-creinstall-once gibo simonwhitaker/gibo'        simonwhitaker/gibo \
    lbin'!bin/xpanes' as'null' has'tmux' greymd/tmux-xpanes

# }}}

# cloneonlyないつまでもロードできなくていいやつ
# {{{

  # フォント系
  # {{{

    zinit lucid as"null" light-mode from"gh-r" cloneonly nocompile for \
      atclone"mkdir -p $ENV_FONT_DIR/Cica; cp ./*.ttf $ENV_FONT_DIR/Cica/"                                           bpick"Cica_*.zip"  miiton/Cica \
      bpick"*Nerd*" atclone"mkdir -p $ENV_FONT_DIR/HackGenNerd; cp ./HackGenNerd_*/*.ttf $ENV_FONT_DIR/HackGenNerd/" yuru7/HackGen

  # }}}

    zinit lucid as'null' light-mode cloneonly nocompile for \
      atclone'mkdir -p $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim && cp -r * $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim' wbthomason/packer.nvim


  # pip3 install
  # {{{

    zinit lucid has"pip3" light-mode nocompile as"null" cloneonly atclone"pip3 install ." atpull"%atclone" for \
      atdelete"pip3 uninstall -y pynvim" neovim/pynvim \
      atdelete"pip3 uninstall -y httpie" httpie/httpie \
      atdelete"pip3 uninstall -y bpytop" aristocratos/bpytop \
      atdelete"pip3 uninstall -y tqdm"   tqdm/tqdm

  # }}}
  
  # tmux plugins
  # {{{
    
    zinit lucid has"tmux" nocompile as"null" light-mode cloneonly atclone"mkdir -p $DOTFILES_PATH/config/tmux/plugins/" atpull"%atclone" for \
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
