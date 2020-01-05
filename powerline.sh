#!/usr/bin/zsh

function powerline_precmd() {
    PS1="$($GOPATH/bin/powerline-go -error $? -shell zsh \
      -modules 'ssh,docker,cwd,git,jobs,exit,newline,user,root' \
      -theme $HOME/.config/powerline-go/default.json \
      -cwd-max-depth 3\
      -cwd-max-dir-size -1)"
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
