# zsh bindings
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

__edit_line__(){
  local FILE="/tmp/$(date "+%s")line.sh"
  echo "$BUFFER" > $FILE &&
    nvim $FILE &&
  BUFFER=$(cat $FILE) &&
  CURSOR=${#BUFFER}
}

zle -N __edit_line__
bindkey "^Xe" __edit_line__

__pickup__() {
  $ZDOTDIR/bin/pickup
}

zle -N __pickup__
bindkey "^p" __pickup__
