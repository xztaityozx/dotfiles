
# {{{

  zinit lucid light-mode src"init.sh" for b4b4r07/enhancd

  zinit from"gh-r" light-mode lucid nocompile for \
    lbin'!lazygit' wait"2" atload"alias lg='lazygit -ucd $HOME/.config/lazygit'" jesseduffield/lazygit \
    lbin'!direnv.* -> direnv' eval'direnv hook zsh' direnv/direnv

  # nvim
  # zinitにrelaeseの名前を解決させることができないのでなんとかする
  zinit ice wait"2" lucid from"gh-r" lbin'!./*/bin/nvim -> nvim'
  zinit light neovim/neovim

  # }}}

  # fzf
  # fzfは補完とかを提供してくれるスクリプトがReleaseのアーカイブに含まれてないのでビルド
  # {{{

    function _fzf_compgen_path() {
      fd --type=f --exclude .git --hidden --follow
    }
    
    function _fzf_compgen_dir() {
      fd --type=f --exclude .git --hidden --follow
    }

    # fzf
    zinit wait"2" atload"_zinit_fzf_atload" light-mode nocompile lucid \
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
  
    zinit has"go" lbin'!powerline-go-* -> powerline-go' light-mode as"null" from"gh-r" \
      atload"source $ZDOTDIR/powerline.zsh" \
        for justjanne/powerline-go

  # }}}
# }}}

# そんなに急いでロードしなくていいツール
# {{{

  zinit wait"2" light-mode nocompile lucid for \
    has"ruby" lbin'!rb' thisredone/rb

  zinit wait"2" light-mode nocompile lucid from"gh-r" for \
    lbin'!*/gojq' atload'alias jq=gojq' itchyny/gojq \
    lbin'!uni-* -> uni' arp242/uni \
    lbin'!gron' tomnomnom/gron \
    lbin'!sad' atload"alias sad='sad --fzf=\"--height=100%\"'" ms-jpq/sad \
    lbin'!owari' atclone'./owari completion zsh > _owari' xztaityozx/owari \
    lbin'!sel'   atclone'./sel completion zsh > _sel' xztaityozx/sel \
    lbin'!bin/teip' greymd/teip \
    lbin'!grex' pemistahl/grex \
    lbin'!./*/bin/gh' atclone'./*/bin/gh completion -s zsh > _gh' atpull"%atclone" cli/cli \
    lbin'!./*/ghq' atclone'rm ./*/misc/bash/_ghq' atpull"%atclone" x-motemen/ghq \
    lbin'!dasel_* -> dasel' atclone'./dasel_* completion zsh > _dasel' TomWright/dasel


  # 最新のものがReleasesにないので自前ビルドする子たち
  zinit wait"zinit-rust-ready" light-mode depth=1 lucid nocompile \
    atclone"cargo build --release" atpull"%atclone" for \
      lbin'!target/release/sd' atload"alias sd='sd -p'" chmln/sd \
      lbin'!target/release/as-tree' jez/as-tree \
      lbin'!target/release/exa' atload"_zinit_exa_atload"  ogham/exa \
      lbin'!target/release/rg' BurntSushi/ripgrep \
      lbin'!target/release/delta' dandavison/delta

  # gh-rにバイナリがあるのではなくcloneすれば実行可能ファイルが手に入る系
  zinit wait'2' nocompile light-mode lucid atpull'%atclone' for \
    lbin'!gibo' atclone'./gibo update;' cp'shell-completions/gibo-completion.zsh -> _gibo' simonwhitaker/gibo \
    lbin'!bin/xpanes' as'null' has'tmux' cp'completion/zsh/_xpanes -> _xpanes' greymd/tmux-xpanes

  zinit wait'2' nocompile as"program" lucid make"all" lbin'!./bin/*' for ryuichiueda/glueutils
# }}}

# {{{
    
    zinit wait"2" lucid as'null' light-mode nocompile for \
      atclone'mkdir -p $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim && cp -r * $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim' wbthomason/packer.nvim

    zinit wait"2" lucid as'null' has"tmux" light-mode nocompile for atload='export TPM_HOME=$PWD' tmux-plugins/tpm

  # pip3 install
  # {{{

    zinit wait"2" lucid has"pip3" light-mode nocompile as"null" atclone"pip3 install ." atpull"%atclone" for \
      atdelete"pip3 uninstall -y pynvim" neovim/pynvim \
      atdelete"pip3 uninstall -y httpie" httpie/httpie \
      atdelete"pip3 uninstall -y bpytop" aristocratos/bpytop

  # }}}

  zinit wait"2" lucid has"perl" nocompile as"program" lbin'!./cpm' for skaji/cpm
# }}}

zinit light-mode has"tmux" trackbinds bindmap"^I -> ^@" atload"_zinit_fzf-tab_atload" for Aloxaf/fzf-tab
zinit light-mode atload"zsh-defer zinit compinit &>/dev/null" for romkatv/zsh-defer

zinit wait lucid for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" zdharma-continuum/fast-syntax-highlighting \
  blockf zsh-users/zsh-completions \
  atload"!_zsh_autosuggest_start" zsh-users/zsh-autosuggestions \
  atload'_zinit_zsh-history-substring-search_atload' zsh-users/zsh-history-substring-search
