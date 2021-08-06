# zsh bindings
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

__insert_awk__(){
  local TEXT="awk '{}'"
  BUFFER=${BUFFER:0:$CURSOR}$TEXT${BUFFER:$CURSOR}
  CURSOR=$(($CURSOR+6))
}
zle -N __insert_awk__
bindkey "^Xawk" __insert_awk__

__edit_line__(){
  local FILE="/tmp/$(date "+%s")line.sh"
  echo "$BUFFER" > $FILE &&
    nvim $FILE &&
  BUFFER=$(cat $FILE) &&
  CURSOR=${#BUFFER}
}

zle -N __edit_line__
bindkey "^Xe" __edit_line__

__local_branch_widget__() {
  local result="$(hub branch | sed 's/[ *]*//g' | fzf)"
  local ret=$?
  zle reset-prompt
  BUFFER=${BUFFER}" "${result}
  CURSOR=${#BUFFER}
  return $ret
}

zle -N __local_branch_widget__
bindkey "^Xb" __local_branch_widget__

__remote_branch_widget__() {
  local result="$(hub branch --remotes | sed 's/[ *]*//g' | fzf)"
  local ret=$?
  zle reset-prompt
  BUFFER=${BUFFER}" "${result}
  CURSOR=${#BUFFER}
  return $ret
}

zle -N __remote_branch_widget__
bindkey "^XB" __remote_branch_widget__
