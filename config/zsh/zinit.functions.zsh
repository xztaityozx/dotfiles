
function zinit-creinstall-once() {
  local CMD_NAME="${1}"
  local FULL_NAME="${2:-$CMD_NAME}"
  [[ -z "$CMD_NAME" ]] && {echo plugin is not specified; return 1}
  [[ ! -f "$ZINIT[COMPLETIONS_DIR]/_${1}" ]] && zinit creinstall "$FULL_NAME"
}

function zinit-rust-ready() {
  [[ -v CARGO_HOME ]] && [[ -v RUSTUP_HOME ]]
}

