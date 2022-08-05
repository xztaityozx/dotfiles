
# {{{

  zinit lucid light-mode src"init.sh" for b4b4r07/enhancd

  zinit from"gh-r" light-mode lucid nocompile for \
    lbin'!lazygit' wait"2" atload"alias lg='lazygit -ucd $HOME/.config/lazygit'" jesseduffield/lazygit \
    lbin'!direnv.* -> direnv' eval'direnv hook zsh' direnv/direnv

  # nvim
  # zinitにrelaeseの名前を解決させることができないのでなんとかする
  zinit ice wait"2" ver"latest" lucid from"gh-r" bpick"nvim-$ENV_OS*.tar.gz" lbin'!./*/bin/nvim -> nvim'
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
  
    zinit has"go" lbin'!powerline-go' light-mode nocompletions nocompile as"null" \
      atclone"go build" atpull"%atclone" \
      atload"source $ZDOTDIR/powerline.zsh" \
        for justjanne/powerline-go

  # }}}
# }}}

# プロンプトが出てから0秒後にロードして欲しいツール
# {{{


# }}}

# そんなに急いでロードしなくていいツール
# {{{

  zinit wait"2" light-mode nocompile lucid for \
    has"ruby" lbin'!rb' thisredone/rb

  # align
  zinit wait"2" nocompile lucid has"go" light-mode lbin'!align' atclone"go build" atpull"%atclone" for jiro4989/align

  zinit wait"2" light-mode nocompile lucid from"gh-r" for \
    lbin'!*/gojq' atload'alias jq=gojq'                        itchyny/gojq \
    lbin'!uni-* -> uni'                                        arp242/uni \
    lbin'!gron'                                                tomnomnom/gron \
    lbin'!sad' atload"alias sad='sad --fzf=\"--height=100%\"'" ms-jpq/sad \
    lbin'!ocs' has"dotnet"                                     xztaityozx/ocs \
    lbin'!*/csvq -> csvq' atload'_zinit_csvq_atload'           mithrandie/csvq \
    lbin'!ojosama'                                             jiro4989/ojosama \
    lbin'!yq_* -> yq' atclone'./yq_* shell-completion zsh > _yq' atpull'%atclone' mikefarah/yq \
    lbin'!smug' has'tmux'                                      ivaaaan/smug


  # sdは最新のデフォルトブランチの内容がRelaeseにアップロードされていないので自前でビルド
  zinit has'fleet' wait"zinit-rust-ready" light-mode lucid nocompile \
    atclone"fleet build" atpull"%atclone" for \
      lbin'!target/debug/sd' atload"alias sd='sd -p'" chmln/sd \
      lbin'!target/debug/as-tree' jez/as-tree

  # gh-rにバイナリがあるのではなくcloneすれば実行可能ファイルが手に入る系
  zinit wait'2' nocompile light-mode lucid atpull'%atclone' for \
    lbin'!gibo' atclone'./gibo update; cp shell-completions/gibo-completion.zsh _gibo' atload'zinit-creinstall-once gibo simonwhitaker/gibo'        simonwhitaker/gibo \
    lbin'!bin/xpanes' as'null' has'tmux' greymd/tmux-xpanes

# }}}

# {{{

  # フォント系
  # {{{

    zinit wait"2" lucid as"null" light-mode from"gh-r" nocompile for \
      bpick"*Nerd*" atclone"mkdir -p $ENV_FONT_DIR/HackGenNerd; cp ./HackGenNerd_*/*.ttf $ENV_FONT_DIR/HackGenNerd/" yuru7/HackGen
      #atclone"mkdir -p $ENV_FONT_DIR/Cica; cp ./*.ttf $ENV_FONT_DIR/Cica/"                        bpick"Cica_*.zip"  miiton/Cica \

  # }}}

    zinit wait"2" lucid as'null' light-mode nocompile for \
      atclone'mkdir -p $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim && cp -r * $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim' wbthomason/packer.nvim


  # pip3 install
  # {{{

    zinit wait"2" lucid has"pip3" light-mode nocompile as"null" atclone"pip3 install ." atpull"%atclone" for \
      atdelete"pip3 uninstall -y pynvim" neovim/pynvim \
      atdelete"pip3 uninstall -y httpie" httpie/httpie \
      atdelete"pip3 uninstall -y bpytop" aristocratos/bpytop \
      atdelete"pip3 uninstall -y tqdm"   tqdm/tqdm

  # }}}
  
  # tmux plugins
  # {{{
    
    zinit wait"2" lucid has"tmux" nocompile as"null" light-mode atclone"mkdir -p $DOTFILES_PATH/config/tmux/plugins/" atpull"%atclone" for \
      cp"prefix_highlight.tmux -> $DOTFILES_PATH/config/tmux/plugins/" tmux-plugins/tmux-prefix-highlight
  # }}}


# }}}

zinit light-mode trackbinds bindmap"^I -> ^@" atload"_zinit_fzf-tab_atload" for Aloxaf/fzf-tab

zinit wait lucid for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" zdharma-continuum/fast-syntax-highlighting \
  blockf zsh-users/zsh-completions \
  atload"!_zsh_autosuggest_start" zsh-users/zsh-autosuggestions \
  atload'_zinit_zsh-history-substring-search_atload' zsh-users/zsh-history-substring-search
