# プロンプトが出る前にロードしてほしいツール
# {{{
  zinit light-mode nocompile from"gh-r" for \
      lbin'!./*/bat -> bat'  mv"./*/autocomplete/bat.zsh -> _bat" atload"_zinit_bat_atload"     @sharkdp/bat \
      eval'linux/go-cdx --init' lbin'!linux/go-cdx -> go-cdx' xztaityozx/go-cdx
# }}}

# プロンプトが出てから0秒後にロードするツール
# {{{
  zinit wait light-mode nocompile lucid from"gh-r" for \
    lbin'!*/rg -> rg' \
      atload'zinit-creinstall-once rg BurntSushi/ripgrep' BurntSushi/ripgrep \
    lbin'!*/delta -> delta' dandavison/delta \
    bpick'*.tar.gz' lbin'!bin/teip -> teip' \
      atload'zinit-creinstall-once teip greymd/teip' greymd/teip \
    lbin'!sel -> sel' atclone'./sel completion zsh > ./_sel' \
      atload'zinit-creinstall-once sel xztaityozx/sel' xztaityozx/sel \
    lbin'!rargs' lotabout/rargs \
    lbin'!*/fd -> fd' @sharkdp/fd \
    lbin'!bin/exa -> exa' cp"completions/exa.zsh -> _exa" \
      atload"_zinit_exa_atload" \
        ogham/exa
# }}}

# そんなに急いでロードしなくていいツール
# {{{
  zinit wait"1" light-mode nocompile lucid from"gh-r" for \
    lbin'!*/bin/gh' bpick'*.tar.gz' \
      atclone'*/bin/gh completion -s zsh > _gh' atpull'%atclone' atload'zinit-creinstall-once gh cli/cli' cli/cli \
    lbin'!*/ghq'       atload'zinit-creinstall-once ghq x-motemen/ghq' x-motemen/ghq \
    lbin'!*/hexyl'                                  @sharkdp/hexyl \
    lbin'!*/hyperfine'                              @sharkdp/hyperfine \
    lbin'!*/pastel'    atload'_zinit_pastel_atload' @sharkdp/pastel \
    lbin'!grex'                                     pemistahl/grex \
    lbin'!linux/owari -> owari' xztaityozx/owari
# }}}
