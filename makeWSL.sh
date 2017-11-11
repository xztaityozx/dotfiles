#!/bin/bash

sudo apt update && sudo apt upgrade -y
sudo apt-add-repository ppa:neovim-ppa/stable
sudo apt update

sudo apt install python3-dev python3-pip python-dev python-pip -y
sudo apt install neovim -y
sudo pip install neovim
sudo pip3 install neovim

mkdir ~/Utils && cd ~/Utils
git clone https://github.com/xztaityozx/dotfiles

mkdir ~/.config
cp -r ./dotfiles/.config/* ~/.config/

pip install --user powerline-status

git clone https://github.com/xztaityozx/cdx
cd cdx
./sh/install.sh

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install


sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

