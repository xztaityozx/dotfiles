#!/usr/bin/env zsh
SCRIPT_DIR=$(cd $(dirname $0); pwd)

echo 'export ZDOTDIR=$HOME/.config/zsh && source $ZDOTDIR/.zshenv' >> $HOME/.zshenv

type apt-get &> /dev/null && {
  echo debian/ubuntu

  sudo apt update && sudo apt upgrade -y
  sudo apt install -y build-essential wget curl git moreutils zip unzip tar
  # pyenv
  sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
                            libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
                            libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

  # rbenv
  # https://github.com/rbenv/ruby-build/wiki#suggested-build-environment
  sudo apt-get install -y autoconf bison build-essential libssl-dev \
                       libyaml-dev libreadline6-dev zlib1g-dev \
                       libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev
}

type brew &> /dev/null && {
  brew install git zsh moreutils coreutils unzip zip wget curl

  # pyenv
  brew install openssl readline sqlite3 xz zlib
  # rbenv
  brew install openssl readline
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

