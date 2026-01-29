
# zinitに構文追加したりするやつ
# {{{

  zinit atinit'Z_A_USECOMP=1' light-mode for NICHOLAS85/z-a-eval
  zinit light NICHOLAS85/z-a-linkbin
  zinit light zdharma-continuum/zinit-annex-bin-gem-node

# }}}

# 言語とかのruntime系
# {{{

  # mise
  # {{{
  zinit as="command" lucid from"gh-r" for \
    id-as=usage atpull="%atclone" jdx/usage \
    id-as=mise mv='mise* -> mise' atclone="./mise completion zsh > _mise" atpull="%atclone" eval'mise activate zsh' jdx/mise

  # }}}
# }}}
