# zsh bindings
bindkey ";5C" forward-word
bindkey ";5D" backward-word
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char

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

