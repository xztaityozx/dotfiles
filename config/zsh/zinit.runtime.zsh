
# zinitに構文追加したりするやつ
# {{{

  zinit atinit'Z_A_USECOMP=1' light-mode for NICHOLAS85/z-a-eval
  zinit light NICHOLAS85/z-a-linkbin
  zinit light zdharma-continuum/zinit-annex-bin-gem-node

# }}}

# 言語とかのruntime系
# {{{

  # asdf
  # {{{
    function _zinit_asdf_atinit() {
      export ASDF_CONFIG_FILE=$DOTFILES_PATH/config/asdf/asdfrc
      unfunction $0
    }

    function __zinit_asdf_atclone_atpull() {
      ./asdf completion zsh > _asdf
    }

    zinit \
      atinit'_zinit_asdf_atinit' \
      atclone"__zinit_asdf_atclone_atpull" atpull"%atclone" \
      atload'export PATH=$HOME/.asdf/shims:$PATH' \
      from"gh-r" \
      completions \
      silent \
      light-mode\
      nocompile\
      lbin'!asdf' for @asdf-vm/asdf 
  # }}}

# }}}
