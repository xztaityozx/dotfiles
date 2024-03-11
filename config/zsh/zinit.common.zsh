
# {{{

  zinit lucid light-mode src"init.sh" for b4b4r07/enhancd

  zinit from"gh-r" light-mode lucid nocompile for \
    lbin'!lazygit' wait"2" atload"alias lg='lazygit -ucd $HOME/.config/lazygit'" jesseduffield/lazygit \
    lbin'!direnv.* -> direnv' eval'direnv hook zsh' direnv/direnv

  # nvim
  # zinitにrelaeseの名前を解決させることができないのでなんとかする
  zinit wait"2" lucid from"gh-r" lbin'!./*/bin/nvim -> nvim' for neovim/neovim

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
  # as"null" をつけないと謎のpreviewスクリプトが暴走してえらいことになる
  # {{{
  
    zinit has"go" lbin'!powerline-go-* -> powerline-go' light-mode as"null" from"gh-r" \
      atload"source $ZDOTDIR/powerline.zsh" \
        for justjanne/powerline-go

  # }}}
# }}}

# そんなに急いでロードしなくていいツール
# {{{

  zinit wait"2" light-mode nocompile lucid from"gh-r" for \
    lbin'!jq* -> jq' jqlang/jq \
    lbin'!uni-* -> uni' arp242/uni \
    lbin'!gron' tomnomnom/gron \
    lbin'!sad' atload"alias sad='sad --fzf=\"--height=100%\"'" bpick"*$(uname|sed 's/Linux/linux-musl/')*" ms-jpq/sad \
    lbin'!owari' atclone'./owari completion zsh > _owari' xztaityozx/owari \
    lbin'!sel'   atclone'./sel completion zsh > _sel' xztaityozx/sel \
    lbin'!bin/teip' greymd/teip \
    lbin'!grex' pemistahl/grex \
    lbin'!./*/bin/gh' atclone'./*/bin/gh completion -s zsh > _gh' atpull"%atclone" cli/cli \
    lbin'!./*/ghq' atclone'rm ./*/misc/bash/_ghq' atpull"%atclone" x-motemen/ghq \
    lbin'!dasel_* -> dasel' atclone'./dasel_* completion zsh > _dasel' TomWright/dasel \
    lbin'!lsd-*/lsd' atload'_zinit_lsd_atload' lsd-rs/lsd \
    lbin'!gibo' atclone'./gibo update && ./gibo completion zsh > _gibo' simonwhitaker/gibo \
    lbin'!./*/rg' bpick"*$(uname -p|sed 's/arm/aarch/')*" BurntSushi/ripgrep \
    lbin'!./*/delta' bpick"*$(uname|sed 's/Linux/linux-musl/')*" dandavison/delta \
    lbin'!*/fd -> fd' bpick"*$(uname|sed 's/Linux/linux-musl/')*"  @sharkdp/fd \
    lbin'!*/hexyl' bpick"*$(uname|sed 's/Linux/linux-musl/')*"  @sharkdp/hexyl \
    lbin'!*/hyperfine'  bpick"*$(uname|sed 's/Linux/linux-musl/')*" @sharkdp/hyperfine \
    lbin'!*/pastel' bpick"*$(uname|sed 's/Linux/linux-musl/')*"  atload'_zinit_pastel_atload' @sharkdp/pastel \
    lbin'!*/bat' bpick"*$(uname|sed 's/Linux/linux-musl/')*"  atload'_zinit_bat_atload' @sharkdp/bat \
    lbin'!sg' atinit"./sg completions zsh > _sg" @ast-grep/ast-grep

  # gh-rにバイナリがあるのではなくcloneすれば実行可能ファイルが手に入る系
  zinit wait'2' nocompile light-mode lucid atpull'%atclone' for \
    lbin'!bin/xpanes' as'null' has'tmux' cp'completion/zsh/_xpanes -> _xpanes' greymd/tmux-xpanes

  zinit wait'5' nocompile as"program" lucid make"all" lbin'!./bin/juz' for ryuichiueda/glueutils
# }}}

# {{{
    
    zinit wait"2" lucid as'null' has"tmux" light-mode nocompile for atload='export TPM_HOME=$PWD' tmux-plugins/tpm

  # pip3 install
  # {{{

    zinit wait"5" lucid has"pip3" light-mode nocompile as"null" atclone"pip3 install ." atpull"%atclone" for \
      atdelete"pip3 uninstall -y pynvim" neovim/pynvim \
      atdelete"pip3 uninstall -y httpie" httpie/httpie

  # }}}

  zinit wait"5" lucid has"perl" nocompile as"program" lbin'!./cpm' for skaji/cpm
# }}}

zinit light-mode has"tmux" trackbinds bindmap"^I -> ^@" atload"_zinit_fzf-tab_atload" for Aloxaf/fzf-tab
zinit light-mode atload"zsh-defer zinit compinit &>/dev/null" for romkatv/zsh-defer

zinit wait lucid for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" zdharma-continuum/fast-syntax-highlighting \
  blockf zsh-users/zsh-completions \
  atload"!_zsh_autosuggest_start" zsh-users/zsh-autosuggestions
