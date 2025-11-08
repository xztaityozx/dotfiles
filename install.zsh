#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname $0); pwd)

# Install zsh if not present
if ! type zsh &> /dev/null; then
  echo "zsh not found, installing..."
  
  if type apt-get &> /dev/null; then
    sudo apt update
    sudo apt install -y zsh
  elif type yum &> /dev/null; then
    sudo yum install -y zsh
  elif type dnf &> /dev/null; then
    sudo dnf install -y zsh
  elif type brew &> /dev/null; then
    brew install zsh
  else
    echo "Error: Could not find a supported package manager to install zsh"
    echo "Please install zsh manually and run this script again"
    exit 1
  fi
  
  # Verify installation
  if ! type zsh &> /dev/null; then
    echo "Error: zsh installation failed"
    exit 1
  fi
  
  echo "zsh installed successfully"
fi

echo 'export ZDOTDIR=$HOME/.config/zsh && source $ZDOTDIR/.zshenv' >> $HOME/.zshenv

type apt-get &> /dev/null && {
  echo debian/ubuntu

  sudo apt update && sudo apt upgrade -y
  sudo apt install -y build-essential wget curl git moreutils zip unzip tar zlib1g zlib1g-dev libssl-dev libbz2-dev libsqlite3-dev liblzma-dev libffi-dev libreadline-dev tk-dev clang lld
}

mkdir -p $HOME/.local/share/nvim/site/autoload

mkdir -p $HOME/.config
ln -s $SCRIPT_DIR/config/* $HOME/.config/
ln -s $SCRIPT_DIR/ideavimrc $HOME/.ideavimrc

