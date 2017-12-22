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
  READLINE_LINE=${READLINE_LINE:0:$READLINE_POINT}" sed ''"${READLINE_LINE:$READLINE_POINT}
  READLINE_POINT=$(($READLINE_POINT+6))
}

bind -x '"\C-xsed":"__insert_sed__"'

__step_up__(){
  local next=$(echo ${READLINE_LINE:0:$READLINE_POINT}|sed 's/[^ ]/1/g'|awk '{print $NF}')
  READLINE_POINT=$(($READLINE_POINT-${#next}-1))
}

bind -x '"\C-b":"__step_up__"'

__step_down__(){
  local next=$(echo ${READLINE_LINE:$READLINE_POINT}|sed 's/[^ ]/1/g'|awk '{print $1}')
  READLINE_POINT=$(($READLINE_POINT+${#next}+1))
}

bind -x '"\C-h":"__step_down__"'

__cdx_bind__(){
  echo "cdx $(find . -mindepth 1 \( -path '*/\.*' \) -prune -o -type d -print|fzf)"
}

bind '"\ecc":"\C-e\C-u$(__cdx_bind__)\e\C-e\er\C-m"'

bind '"\ech":"\C-e\C-ucdx -h\e\C-e\er\C-m"'
bind '"\ecb":"\C-e\C-ucdx -b\e\C-e\er\C-m"'

__opennvim__(){ local f=$(__fzf_select__); READLINE_LINE="nvim "$f; READLINE_POINT=$((4+${#f})); }
bind -x '"\C-nn":"__opennvim__"'


__insert_single_q__(){
  READLINE_LINE=$READLINE_LINE" ''"
  READLINE_POINT=$(($READLINE_POINT+2))
}

bind -x '"\es":"__insert_single_q__"'

