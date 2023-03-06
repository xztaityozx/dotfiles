
# {{{

  zinit lucid light-mode src"init.sh" for b4b4r07/enhancd

  zinit from"gh-r" light-mode lucid nocompile for \
    lbin'!lazygit' wait"2" atload"alias lg='lazygit -ucd $HOME/.config/lazygit'" jesseduffield/lazygit \
    lbin'!direnv.* -> direnv' eval'direnv hook zsh' direnv/direnv

  # nvim
  # zinitにrelaeseの名前を解決させることができないのでなんとかする
  zinit ice wait"2" lucid from"gh-r" lbin'!./*/bin/nvim -> nvim'
  zinit light neovim/neovim

  zinit has"docker" lbin'!./dest/bin/tmux -> tmux' atpull"make clean" light-mode nocompile make'!!' \
    cp"./dest/man/man1/tmux.1 -> $ZPFX/man/man1/tmux.1" for xztaityozx/tmux-builder

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
  
    zinit has"go" lbin'!powerline-go' light-mode nocompletions nocompile as"null" \
      atclone"go build" atpull"%atclone" \
      atload"source $ZDOTDIR/powerline.zsh" \
        for justjanne/powerline-go

  # }}}
# }}}

# そんなに急いでロードしなくていいツール
# {{{

  zinit wait"2" light-mode nocompile lucid for \
    has"ruby" lbin'!rb' thisredone/rb

  # align
  zinit wait"2" nocompile lucid has"go" light-mode lbin'!align' atclone"go build" atpull"%atclone" for jiro4989/align

  zinit wait"2" light-mode nocompile lucid from"gh-r" for \
    lbin'!*/gojq' atload'alias jq=gojq'                          itchyny/gojq \
    lbin'!uni-* -> uni'                                          arp242/uni \
    lbin'!gron'                                                  tomnomnom/gron \
    lbin'!sad' atload"alias sad='sad --fzf=\"--height=100%\"'"   ms-jpq/sad \
    lbin'!*/csvq -> csvq' atload'_zinit_csvq_atload'             mithrandie/csvq \
    lbin'!ojosama'                                               jiro4989/ojosama \
    lbin'!owari' atclone'./owari completion zsh > _owari'        xztaityozx/owari \
    lbin'!sel'   atclone'./sel completion zsh > _sel'            xztaityozx/sel \
    lbin'!yq_* -> yq' atclone'./yq_* shell-completion zsh > _yq' atpull'%atclone' mikefarah/yq


  # sdは最新のデフォルトブランチの内容がRelaeseにアップロードされていないので自前でビルド
  zinit wait"zinit-rust-ready" light-mode lucid nocompile \
    atclone"cargo build" atpull"%atclone" for \
      lbin'!target/debug/sd' atload"alias sd='sd -p'" chmln/sd \
      lbin'!target/debug/as-tree'                     jez/as-tree

  # gh-rにバイナリがあるのではなくcloneすれば実行可能ファイルが手に入る系
  zinit wait'2' nocompile light-mode lucid atpull'%atclone' for \
    lbin'!gibo' atclone'./gibo update;' cp'shell-completions/gibo-completion.zsh -> _gibo' simonwhitaker/gibo \
    lbin'!bin/xpanes' as'null' has'tmux' cp'completion/zsh/_xpanes -> _xpanes'             greymd/tmux-xpanes

  zinit wait'2' nocompile as"program" lucid make"all" lbin'!./bin/*' for ryuichiueda/glueutils

  # textimgはarm向けのビルドが無いので自前ビルド
  zinit has'go' wait'2' nocompile as"program" atclone'asdf local golang 1.19.3' lucid make"textimg" lbin'!textimg' cp'completions/zsh/_textimg -> _textimg' for jiro4989/textimg
# }}}

# {{{
    
    zinit wait"2" lucid as'null' light-mode nocompile for \
      atclone'mkdir -p $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim && cp -r * $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim' wbthomason/packer.nvim

    zinit wait"2" lucid as'null' has"tmux" light-mode nocompile cloneonly for atload='export TPM_HOME=$PWD' tmux-plugins/tpm

    zinit wait"2" lucid as'program' light-mode lbin'!shellspec' for @shellspec/shellspec

  # pip3 install
  # {{{

    zinit wait"2" lucid has"pip3" light-mode nocompile as"null" atclone"pip3 install ." atpull"%atclone" for \
      atdelete"pip3 uninstall -y pynvim" neovim/pynvim \
      atdelete"pip3 uninstall -y httpie" httpie/httpie \
      atdelete"pip3 uninstall -y bpytop" aristocratos/bpytop \
      atdelete"pip3 uninstall -y tqdm"   tqdm/tqdm

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
