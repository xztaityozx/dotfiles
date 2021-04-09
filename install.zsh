#!/usr/bin/env zsh
SCRIPT_DIR=$(cd $(dirname $0); pwd)

echo 'export ZDOTDIR=$HOME/.config/zsh && source $ZDOTDIR/.zshenv' >> $HOME/.zshenv

type apt &> /dev/null && {
  echo debian/ubuntu

  sudo apt update && sudo apt upgrade -y
  sudo apt install -y build-essential wget curl git moreutils
}

type brew &> /dev/null && {
  brew install git zsh moreutils
}

type pacman &> /dev/null && {
  sudo pacman -Ss git zsh
}

mkdir -p $HOME/.local/share/nvim/site/autoload

# zinit
mkdir -p $SCRIPT_DIR/config/zsh/.zinit
git clone https://github.com/zdharma/zinit.git $SCRIPT_DIR/config/zsh/.zinit/bin

ln -s $SCRIPT_DIR/config/* $HOME/.config/
ln -s $SCRIPT_DIR/ideavimrc $HOME/.ideavimrc

make
