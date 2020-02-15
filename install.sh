#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0); pwd)

echo 'export ZDOTDIR=$HOME/.config/zshi && source $ZDOTDIR/.zshenv' >> $HOME/.zshenv

#sudo apt update && sudo apt upgrade -y
#sudo apt install -y build-essential wget curl git moreutils

ls $SCRIPT_DIR/config/zsh/packages/*.zsh | xargs -I@ "zsh @"

ln -s $SCRIPT_DIR/config/* $HOME/.config/
ln -s $SCRIPT_DIR/ideavimrc $HOME/.ideavimrc
