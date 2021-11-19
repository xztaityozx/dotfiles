#!/usr/bin/zsh

function powerline_precmd() {
  local err=$?
  if [[ "$SIMPLE_POWERLINE" == 1 ]]; then
    PS1="$(powerline-go -shell zsh -error $err \
      -modules 'root' \
      -theme $HOME/.config/powerline-go/default.json)"
  else
    PS1="$(powerline-go -error $err -shell zsh \
      -hostname-only-if-ssh \
      -modules 'aws,ssh,host,docker,cwd,git,jobs,exit,newline,user,root' \
      -theme $HOME/.config/powerline-go/default.json \
      -shell zsh \
      -cwd-max-depth 3\
      -cwd-max-dir-size -1)"
  fi
  true
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
  install_powerline_precmd
fi
