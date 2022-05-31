
# zinitに構文追加したりするやつ
# {{{

  zinit atinit'Z_A_USECOMP=1' light-mode for NICHOLAS85/z-a-eval
  zinit light NICHOLAS85/z-a-linkbin
  zinit light zdharma-continuum/zinit-annex-bin-gem-node
  zinit light zdharma-continuum/zinit-annex-rust

# }}}

# 言語とかのruntime系
# {{{

  # anyenv
  # {{{
    # anyenvのzshを起動するたびに実行する部分
    function _zinit_anyenv_atload() {

      add-zsh-hook -L precmd | grep __hook-anyenv-post-install-env &>/dev/null || {
        add-zsh-hook precmd __hook-anyenv-post-install-env
      }
      unfunction $0
    }

    # anyenv install した後initスクリプトを更新するHook
    function __hook-anyenv-post-install-env() {
      [[ "${1}" =~ "anyenv install" ]] && zinit recache anyenv/anyenv
      true
    }

    zinit ice pick'bin/anyenv' as"program" atclone"yes | bin/anyenv install --init" eval"bin/anyenv init --no-rehash - zsh | sed 's@goenv rehash --only-manage-paths@#&@'" \
      atload'export ANYENV_ROOT=$PWD;_zinit_anyenv_atload' \
      atpull"anyenv install --update"
    zinit light anyenv/anyenv

    zinit ice wait'[[ -n "$(type anyenv)" ]]' lucid has"anyenv" cloneonly nocompile \
      atclone"mkdir -p $(anyenv root)/plugins/anyenv-update && cp -r * $(anyenv root)/plugins/anyenv-update" \
      atpull"%atclone"
    zinit light znz/anyenv-update

    # anyenvでなんもインストールされてなかったらセットアップ開始する
    [[ -z "$(anyenv versions 2>&1)" ]] && {
        VERSIONS="
goenv 
plenv 
pyenv 
nodenv
rbenv
tfenv"

      echo "$VERSIONS" | while read L; do anyenv install "$L" --skip-existing ; done

        zinit recache anyenv/anyenv
        source "$(anyenv root)/evalcache.zsh"

        zinit ice has"nodenv" cloneonly nocompile \
          atclone'mkdir -p $(nodenv root)/plugins/nodenv-yarn-install && cp -r * $(nodenv root)/plugins/nodenv-yarn-install/' \
          atpull"%atclone"
        zinit light pine/nodenv-yarn-install

        PYENV_GLOBAL_VERSION=3.10.4
        pyenv install "$PYENV_GLOBAL_VERSION"
        pyenv global "$PYENV_GLOBAL_VERSION"

        goenv install 1.16.5 --skip-existing
        goenv install 1.18.0 --skip-existing
        goenv global 1.18.0

        nodenv install 16.8.0 --skip-existing
        nodenv global 16.8.0

        rbenv install 3.1.1
        rbenv global 3.1.1
    }
  # }}}
  
  # rust
  #{{{

    zinit id-as"rust" as=null sbin"bin/*" lucid rustup \
      atload"[[ ! -f ${ZINIT[COMPLETIONS_DIR]}/_cargo ]] && zinit creinstall -Q rust; export CARGO_HOME=\$PWD RUSTUP_HOME=\$PWD/rustup" for \
        xztaityozx/null

    zinit light-mode nocompile lucid wait'zinit-rust-ready' lucid for \
      id-as'fleet' cargo'fleet <- !fleet-rs' xztaityozx/null \
      id-as'sccache' cargo'sccache' xztaityozx/null
  #}}}

# }}}
