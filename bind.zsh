# zsh bindings
bindkey ";5C" forward-word
bindkey ";5D" backward-word

__git_set__(){
  local TEXT='git add -A;git commit -m "";git push'
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


