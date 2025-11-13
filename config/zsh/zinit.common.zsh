
# {{{

zinit lucid light-mode for romkatv/zsh-defer
zsh-defer zinit lucid light-mode src"init.sh" for b4b4r07/enhancd
zsh-defer zinit from"gh-r" light-mode lucid nocompile for lbin'!direnv.* -> direnv' eval'direnv hook zsh' direnv/direnv

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
    zsh-defer zinit wait"2" atload"__zinit_fzf_atload" light-mode nocompile lucid \
      cloneopts"--depth 1" \
      lbin'!bin/{fzf,fzf-tmux}' \
      atclone"./install --bin --no-{zsh,bash,fish,completion,key-bindings}" atpull"%atclone" \
      eval'cat shell/*.zsh' \
        for junegunn/fzf

  # }}}
  
  # powerline-go
  # as"null" をつけないと謎のpreviewスクリプトが暴走してえらいことになる
  # {{{
  
    zinit has"go" lbin'!powerline-go-* -> powerline-go' light-mode as"null" from"gh-r" \
      atload"source $ZDOTDIR/powerline.zsh" \
        for justjanne/powerline-go

  # }}}
# }}}

# そんなに急いでロードしなくていいツール
# {{{

  __zinit_OS_NAME_FOR_RUST_TOOLS=$(uname|sed 's/Linux/linux-musl/')
  zsh-defer zinit wait"2" light-mode nocompile lucid from"gh-r" completions for \
    lbin'!./*/bin/nvim -> nvim' bpick"*.tar.gz"                                                                                 neovim/neovim \
    lbin'!jq* -> jq'                                                                                                            jqlang/jq \
    lbin'!uni-* -> uni'                                                                                                         arp242/uni \
    lbin'!gron'                                                                                                                 tomnomnom/gron \
    lbin'!lazygit'          atload"alias lg='lazygit -ucd $HOME/.config/lazygit'"                                               jesseduffield/lazygit \
    lbin'!owari'            atclone'./owari completion zsh > _owari'                                                            xztaityozx/owari \
    lbin'!sel'              atclone'./sel completion zsh > _sel'                                                                xztaityozx/sel \
    lbin'!bin/teip'                                                                                                             greymd/teip \
    lbin'!grex'                                                                                                                 pemistahl/grex \
    lbin'!./*/bin/gh'       atclone'./*/bin/gh completion -s zsh > _gh'             atpull"%atclone"                            cli/cli \
    lbin'!./*/ghq'          atclone'rm ./*/misc/bash/_ghq'                          atpull"%atclone"                            x-motemen/ghq \
    lbin'!dasel_* -> dasel' atclone'./dasel_* completion zsh > _dasel'                                                          TomWright/dasel \
    lbin'!lsd-*/lsd'        atload'__zinit_lsd_atload'                                                                           lsd-rs/lsd \
    lbin'!gibo'             atclone'./gibo update && ./gibo completion zsh > _gibo' atpull"%atclone"                            simonwhitaker/gibo \
    lbin'!./*/rg'                                                                   bpick"*$(uname -p|sed 's/arm/aarch/')*"     BurntSushi/ripgrep \
    lbin'!./*/delta'                                                                bpick"*$(uname -p|sed 's/arm/aarch/')*"     dandavison/delta \
    lbin'!*/fd -> fd'                                                               bpick"*${__zinit_OS_NAME_FOR_RUST_TOOLS}*"  @sharkdp/fd \
    lbin'!*/hexyl'                                                                  bpick"*${__zinit_OS_NAME_FOR_RUST_TOOLS}*"  @sharkdp/hexyl \
    lbin'!*/hyperfine'                                                              bpick"*${__zinit_OS_NAME_FOR_RUST_TOOLS}*"  @sharkdp/hyperfine \
    lbin'!*/pastel'         atload'__zinit_pastel_atload'                            bpick"*${__zinit_OS_NAME_FOR_RUST_TOOLS}*"  @sharkdp/pastel \
    lbin'!*/bat'            atload'__zinit_bat_atload'                               bpick"*${__zinit_OS_NAME_FOR_RUST_TOOLS}*"  @sharkdp/bat \
    lbin'!sad'              atload"alias sad='sad --fzf=\"--height=100%\"'"         bpick"*${__zinit_OS_NAME_FOR_RUST_TOOLS}*.zip"  ms-jpq/sad \
    lbin'!pinact'           atclone'./pinact completion zsh > _pinact' atpull"%atclone"                                          suzuki-shunsuke/pinact

  # gh-rにバイナリがあるのではなくcloneすれば実行可能ファイルが手に入る系
  zsh-defer zinit wait'2' nocompile light-mode lucid atpull'%atclone' for \
    lbin'!bin/xpanes' as'null' has'tmux' cp'completion/zsh/_xpanes -> _xpanes' greymd/tmux-xpanes

  zsh-defer zinit wait'2' nocompile as"program" lucid pick"$ZPFX/bin/nb" atclone"cp etc/nb-completion.zsh _nb" atpull"%atclone" make"PREFIX=$ZPFX" for xwmx/nb

  # macでビルドできないので一旦OFF
  #zsh-defer zinit wait'5' nocompile as"program" lucid make"all" lbin'!./bin/juz' for ryuichiueda/glueutils
# }}}

# {{{
    
  zsh-defer zinit wait"2" if"$TMUX" lucid as'null' has"tmux" light-mode nocompile for atload='export TPM_HOME=$HOME/.local/share/tpm' tmux-plugins/tpm

  # pip3 install
  # {{{

  zsh-defer zinit wait"5" lucid as'null' has"pip3" light-mode nocompile atclone"pip3 install --user ." atpull"%atclone" for \
    atdelete"pip3 uninstall -y pynvim" neovim/pynvim \
    atdelete"pip3 uninstall -y httpie" httpie/httpie

  # }}}

  zsh-defer zinit wait"5" lucid has"perl" nocompile as"program" lbin'!./cpm' for skaji/cpm
# }}}

zsh-defer zinit lucid light-mode has"tmux" trackbinds bindmap"^I -> ^@" atload"__zinit_fzf-tab_atload" for Aloxaf/fzf-tab

zsh-defer zinit wait lucid for \
  zdharma-continuum/fast-syntax-highlighting \
  blockf atload="zicompinit; zicdreplay" zsh-users/zsh-completions \
  atload"!_zsh_autosuggest_start" zsh-users/zsh-autosuggestions
