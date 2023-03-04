#!/usr/bin/zsh

zmodload zsh/datetime

function powerline_preexec() {
  __TIMER=$EPOCHREALTIME
}

function powerline_precmd() {
  local err=$?
  local duration=0

  if [[ -n $EPOCHREALTIME ]]; then
    local __ERT=$EPOCHREALTIME;
    duration="$(($__ERT - ${__TIMER:-__ERT}))"
  fi

  if [[ "$SIMPLE_POWERLINE" == 1 ]]; then
    PS1="$(powerline-go -shell zsh -error $err \
      -modules 'root' \
      -theme $HOME/.config/powerline-go/default.json)"
  else
    PS1="$(powerline-go -error $err -shell zsh \
      -hostname-only-if-ssh \
      -modules 'aws,ssh,host,docker,cwd,git,jobs,duration,time,exit,newline,user,root' \
      -theme $HOME/.config/powerline-go/default.json \
      -duration $duration \
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

function install_powerline_preexec() {
  for s in "${preexec_functions[@]}"; do
    if [ "$s" = "powerline_preexec" ]; then
      return
    fi
  done
  preexec_functions+=(powerline_preexec)
}

if [ "$TERM" != "linux" ]; then
  install_powerline_precmd
  install_powerline_preexec
fi
