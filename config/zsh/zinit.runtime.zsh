
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

    function _zinit_asdf_atload() {
      unfunction $0

      [[ "$ZINIT_ATCLONE" != 1 ]] || return 0

      cd "$ZDOTDIR"
      asdf plugin add golang
      asdf plugin add python
      asdf install

      asdf global golang 1.19.3
      asdf global python 3.10.8
    }

    zinit atinit'_zinit_asdf_atinit' atclone"expor ZINIT_ATCLONE=1" pick"asdf.sh" atload"_zinit_asdf_atload" light-mode for @asdf-vm/asdf
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
