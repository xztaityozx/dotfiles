#!/usr/bin/env zsh
SCRIPT_DIR=$(cd $(dirname $0); pwd)

echo 'export ZDOTDIR=$HOME/.config/zsh && source $ZDOTDIR/.zshenv' >> $HOME/.zshenv

type apt &> /dev/null && {
  echo debian/ubuntu

  sudo apt update && sudo apt upgrade -y
  sudo apt install -y build-essential wget curl git moreutils
  # pyenv
  sudo apt-get install make build-essential libssl-dev zlib1g-dev \
                            libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
                            libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
}

type brew &> /dev/null && {
  brew install git zsh moreutils

  # pyenv
  brew install openssl readline sqlite3 xz zlib
}

type pacman &> /dev/null && {
  sudo pacman -Ss git zsh
}

mkdir -p $HOME/.local/share/nvim/site/autoload

# zinit
mkdir -p $SCRIPT_DIR/config/zsh/.zinit
git clone https://github.com/zdharma/zinit.git $SCRIPT_DIR/config/zsh/.zinit/bin

mkdir -p $HOME/.config
ln -s $SCRIPT_DIR/config/* $HOME/.config/
ln -s $SCRIPT_DIR/ideavimrc $HOME/.ideavimrc

make
