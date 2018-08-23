#!/bin/bash

function Print() {
  # $@ = Messages

  echo -e "\e[1;39m$@\e[0;39m"
}

__log_num=1
function LogAndRun() {
  # $@ Command

  echo -e "\e[1;31m[$__log_num]$@\e[0;39m" && eval "$@" || exit 1
  __log_num=$(echo $(($__log_num+1)))
}

function Fatal() {
  # $@ = Messages

  echo -e "\e[1;32m$@\e[0;39m"
  exit 1
}

# sudo authentication
sudo echo "Authorized!" || Fatal "Failed"

# update
LogAndRun "sudo apt update && sudo apt upgrade -y"

# install packages
LogAndRun "sudo apt install -y git curl zsh wget make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev"

# install brew
LogAndRun "sudo apt install -y linuxbrew-wrapper"
LogAndRun "yes|brew"
LogAndRun "export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin"

# install any packages from brew
LogAndRun "brew install fzf pyenv hub ghq go exa gcc zplug"

# go
LogAndRun "export GOPATH=$HOME/.go"
LogAndRun "go get github.com/xztaityozx/go-cdx"

# pyenv
LogAndRun "eval \"$(pyenv init -)\""
LogAndRun "CFLAGS=\"-I$(brew --prefix openssl)/include\" LDFLAGS=\"-L$(brew --prefix openssl)/lib\" pyenv install -v 3.6.5"
LogAndRun "CFLAGS=\"-I$(brew --prefix openssl)/include\" LDFLAGS=\"-L$(brew --prefix openssl)/lib\" pyenv install -v 2.7.15"
LogAndRun "pyenv global 3.6.5 2.7.15"

# pip
LogAndRun "pip3 install --upgrade pip"
LogAndRun "pip2 install --upgrade pip"
LogAndRun "pip3 install neovim"
LogAndRun "pip2 install neovim"

# neovim
LogAndRun "curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

# zplug
LogAndRun "zplug install"

# complete
Print "Complete"
