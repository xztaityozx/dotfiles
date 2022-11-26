#!/usr/bin/env zsh
SCRIPT_DIR=$(cd $(dirname $0); pwd)

echo 'export ZDOTDIR=$HOME/.config/zsh && source $ZDOTDIR/.zshenv' >> $HOME/.zshenv

type apt-get &> /dev/null && {
  echo debian/ubuntu

  sudo apt update && sudo apt upgrade -y
  sudo apt install -y build-essential wget curl git moreutils zip unzip tar zlib1g zlib1g-dev libssl-dev libbz2-dev libsqlite3-dev liblzma-dev libffi-dev libreadline-dev tk-dev
}

type brew &> /dev/null && {
  brew install git zsh moreutils coreutils unzip zip wget curl
}

type pacman &> /dev/null && {
  sudo pacman -Ss git zsh wget curl moreutils zip unzip tar
}

mkdir -p $HOME/.local/share/nvim/site/autoload

# zinit
mkdir -p $SCRIPT_DIR/config/zsh/.zinit
git clone https://github.com/zdharma-continuum/zinit.git $SCRIPT_DIR/config/zsh/.zinit/bin

mkdir -p $HOME/.config
ln -s $SCRIPT_DIR/config/* $HOME/.config/
ln -s $SCRIPT_DIR/ideavimrc $HOME/.ideavimrc

