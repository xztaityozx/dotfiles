# zsh bindings
bindkey ";5C" forward-word
bindkey ";5D" backward-word
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char

__git_set__(){
  local TEXT='hub add -A;hub commit -m "";hub push'
  BUFFER=$TEXT
  CURSOR=26
}

zle -N __git_set__
bindkey "^Xgit" __git_set__

# from https://github.com/kunst1080/dotfiles/blob/master/all/.zshrc.bind
__insert_awk__(){
  local TEXT="awk '{}'"
  BUFFER=${BUFFER:0:$CURSOR}$TEXT${BUFFER:$CURSOR}
  CURSOR=$(($CURSOR+6))
}
zle -N __insert_awk__
bindkey "^Xawk" __insert_awk__

__sround_echo_zshrc__(){
  BUFFER="echo '"$BUFFER"' >> ~/.zshrc"
}
zle -N __sround_echo_zshrc__
bindkey "^Xrc" __sround_echo_zshrc__

__insert_sed__(){
  BUFFER=${BUFFER:0:$CURSOR}" sed ''"${BUFFER:$CURSOR}
  CURSOR=$(($CURSOR+6))
}
zle -N __insert_sed__
bindkey "^Xsed" __insert_sed__

__xsel_b__(){
  BUFFER=${BUFFER}"|xsel -b"
}

zle -N __xsel_b__
bindkey "^Xxx" __xsel_b__

__edit_line__(){
  local FILE="/tmp/$(date "+%s")line.sh"
  echo "$BUFFER" > $FILE &&
    nvim $FILE &&
  BUFFER=$(cat $FILE) &&
  CURSOR=${#BUFFER}
}

zle -N __edit_line__
bindkey "^Xe" __edit_line__
