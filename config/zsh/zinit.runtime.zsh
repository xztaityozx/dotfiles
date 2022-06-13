
# zinitに構文追加したりするやつ
# {{{

  zinit atinit'Z_A_USECOMP=1' light-mode for NICHOLAS85/z-a-eval
  zinit light NICHOLAS85/z-a-linkbin
  zinit light zdharma-continuum/zinit-annex-bin-gem-node
  zinit light zdharma-continuum/zinit-annex-rust

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
  
  # rust
  #{{{

    zinit id-as"rust" as=null sbin"bin/*" lucid rustup \
      atload"[[ ! -f ${ZINIT[COMPLETIONS_DIR]}/_cargo ]] && zinit creinstall -Q rust; export CARGO_HOME=\$PWD RUSTUP_HOME=\$PWD/rustup" for \
        xztaityozx/null

    zinit light-mode nocompile lucid wait'zinit-rust-ready' lucid for \
      id-as'fleet' cargo'fleet <- !fleet-rs' xztaityozx/null

  #}}}

# }}}
