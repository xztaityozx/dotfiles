
# Go言語製のツール
# {{{

  zinit has'go' light-mode nocompile lucid atclone"go build" atpull"%atclone" for \
    eval'./go-cdx --init' lbin'!go-cdx' xztaityozx/go-cdx \
    wait"3" lbin'!owari' xztaityozx/owari \
    wait"3" make'!install prefix=$ZPFX' atclone'gh completion -s zsh > _gh' atload'zinit-creinstall-once gh cli/cli' cli/cli \
    wait"3" make'!build' lbin'!ghq' atload'zinit-creinstall-once ghq x-motemen/ghq' x-motemen/ghq \
    wait"3" atclone'go build' lbin'!gron' tomnomnom/gron \
    wait lbin"!sel" atclone"go build && ./sel completion zsh > _sel" xztaityozx/sel

# }}}

# Rust製のツール
# {{{

  zinit has'fleet' light-mode nocompile lucid wait'zinit-rust-ready' depth=1 lucid \
    atclone"hub restore ./;fleet build" atpull"%atclone" for \
      lbin'!target/debug/bat' atload"_zinit_bat_atload"       @sharkdp/bat \
      lbin'!target/debug/hexyl'                               @sharkdp/hexyl \
      lbin'!target/debug/fd'                                  @sharkdp/fd \
      lbin'!target/debug/pastel' atload'_zinit_pastel_atload' @sharkdp/pastel \
      lbin'!target/debug/hyperfine'                           @sharkdp/hyperfine \
      lbin'!target/debug/exa' atload'zinit-creinstall-once exa ogham/exa;_zinit_exa_atload' ogham/exa \
      lbin'!target/debug/delta' dandavison/delta \
      lbin'!target/debug/rg'    BurntSushi/ripgrep \
      lbin'!target/debug/teip'  greymd/teip \
      lbin'!target/debug/grex'  pemistahl/grex

# }}}
