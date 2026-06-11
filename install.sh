#!/usr/bin/env zsh
SCRIPT_DIR=$(cd $(dirname $0); pwd)

echo 'export ZDOTDIR=$HOME/.config/zsh && source $ZDOTDIR/.zshenv' >> $HOME/.zshenv

export ZDOTDIR=$HOME/.config/zsh

mkdir -p $HOME/.local/share/nvim/site/autoload

mkdir -p $HOME/.config
ln -s $SCRIPT_DIR/config/* $HOME/.config/
ln -s $SCRIPT_DIR/ideavimrc $HOME/.ideavimrc

cd $HOME/.config/zsh && make
