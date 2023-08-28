
# Go言語製のツール
# {{{

  zinit has'go' light-mode nocompile lucid atclone"asdf local golang 1.19.3 && go build" atpull"%atclone" for \
    eval'./go-cdx --init' lbin'!go-cdx' xztaityozx/go-cdx

# }}}

# Rust製のツール
# {{{

  zinit light-mode nocompile lucid wait'zinit-rust-ready' depth=1 lucid \
    atclone"git restore ./ && cargo build" atpull"%atclone" for \
      lbin'!target/debug/bat'    atload"_zinit_bat_atload"    @sharkdp/bat \
      lbin'!target/debug/hexyl'                               @sharkdp/hexyl \
      lbin'!target/debug/fd'                                  @sharkdp/fd \
      lbin'!target/debug/pastel' atload'_zinit_pastel_atload' @sharkdp/pastel \
      lbin'!target/debug/hyperfine'                           @sharkdp/hyperfine
# }}}
