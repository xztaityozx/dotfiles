# プロンプトが出る前にロードしてほしいツール
# {{{
  zinit light-mode nocompile from"gh-r" for \
      lbin'!./*/bat -> bat'  mv"./*/autocomplete/bat.zsh -> _bat" atload"_zinit_bat_atload"     @sharkdp/bat \
      eval'linux/go-cdx --init' lbin'!linux/go-cdx -> go-cdx' xztaityozx/go-cdx
# }}}

# プロンプトが出てから0秒後にロードするツール
# {{{
  zinit wait light-mode nocompile lucid from"gh-r" for \
    lbin'!rargs' lotabout/rargs \
    lbin'!*/fd -> fd' @sharkdp/fd
# }}}

# そんなに急いでロードしなくていいツール
# {{{
  zinit wait"5" light-mode nocompile lucid from"gh-r" for \
    lbin'!*/hexyl' @sharkdp/hexyl \
    lbin'!*/hyperfine' @sharkdp/hyperfine \
    lbin'!*/pastel' atload'_zinit_pastel_atload' @sharkdp/pastel
# }}}
