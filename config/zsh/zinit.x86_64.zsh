# プロンプトが出る前にロードしてほしいツール

# プロンプトが出てから0秒後にロードするツール
# {{{
  zinit wait light-mode nocompile lucid from"gh-r" for \
    lbin'!*/fd -> fd' @sharkdp/fd
# }}}

# そんなに急いでロードしなくていいツール
# {{{
  zinit wait"5" light-mode nocompile lucid from"gh-r" for \
    lbin'!*/hexyl' @sharkdp/hexyl \
    lbin'!*/hyperfine' @sharkdp/hyperfine \
    lbin'!*/pastel' atload'_zinit_pastel_atload' @sharkdp/pastel
# }}}
