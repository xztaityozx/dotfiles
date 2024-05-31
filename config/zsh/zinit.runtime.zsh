
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
      export ASDF_DIR=$PWD
      export ASDF_DATA_DIR=$PWD
      export ASDF_CONFIG_FILE=$DOTFILES_PATH/config/asdf/asdfrc
      unfunction $0
    }

    zinit atinit'_zinit_asdf_atinit' pick"asdf.sh" light-mode for @asdf-vm/asdf
  # }}}

# }}}
