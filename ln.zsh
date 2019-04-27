#!/usr/bin/zsh

REPO="$HOME/.ghq/github.com/xztaityozx/dotfiles/"

ln -s $REPO/config/* $HOME/.config/
ln -s $REPO/zshrc $HOME/.zshrc
ln -s $REPO/zprofile $HOME/.zprofile
ln -s $REPO/ideavimrc $HOME/.ideavimrc
