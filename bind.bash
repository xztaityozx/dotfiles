#!/bin/bash

__insert_awk__(){
  local TEXT="awk '{}'"
  READLINE_LINE=${READLINE_LINE:0:$READLINE_POINT}$TEXT${READLINE_LINE:$READLINE_POINT}
  READLINE_POINT=$(($READLINE_POINT+6))
}

bind -x '"\C-xawk":"__insert_awk__"'

__sround_echo_bashrc__(){
  READLINE_LINE="echo '"$READLINE_LINE"' >> ~/.bashrc"
}

bind -x '"\C-xrc":"__sround_echo_bashrc__"'

__git_push_set__(){
  READLINE_LINE="git add -A;git commit -m \"\";git push"
  READLINE_POINT=26
}

bind -x '"\C-xgit":"__git_push_set__"'

__insert_sed__(){
  READLINE_LINE=${READLINE_LINE:0:$READLINE_POINT}" sed \'\'"${READLINE_LINE:$READLINE_POINT}
  READLINE_POINT=$(($READLINE_POINT+6))
}

bind -x '"\C-xsed":"__insert_sed__"'

__step_up__(){
  local upper=${READLINE_LINE:0:$READLINE_POINT}
  
}

bind -x '"\C-xb":"__step_up__"'
