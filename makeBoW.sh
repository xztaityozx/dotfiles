#!/bin/bash

sudo apt install -y aptitude
sudo aptitude install -y gnome-terminal
sudo apt install -y python-dev python-pip python3-dev python3-pip
sudo pip install neovim
sudo pip3 install neovim
sudo apt install -y software-properties-common
sudo apt-add-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install -y neovim
git clone https://github.com/xztaityozx/dotfiles
cp ~/dotfiles/.tmux.conf ~/
if [ -e ~/.config ]; then
  cp -r ~/dotfiles/.config/* ~/.config/
else
  mkdir ~/.config/
  cp -r ~/dotfiles/.config/* ~/.config/
fi
sudo apt install fontforge
mkdir ~/Ricty
cd ~/Ricty
wget http://www.rs.tus.ac.jp/yyusa/ricty/ricty_generator.sh
wget https://github.com/google/fonts/blob/master/ofl/inconsolata/Inconsolata-Bold.ttf
wget https://github.com/google/fonts/blob/master/ofl/inconsolata/Inconsolata-Regular.ttf
wget --trust-server-name  "https://ja.osdn.net/frs/redir.php?m=iij&f=%2Fmix-mplus-ipa%2F63545%2Fmigu-1m-20150712.zip"
sudo apt install unzip
unzip migu-1m-20150712.zip
cp ./migu-1m-20150712/**.ttf ./
chmod +x ./ricty_generator.sh
./ricty_generator.sh auto

sudo apt install uim-fep uim-anthy
cd ~
touch ~/.uim

git clone https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

cd ~
mkdir Utils
cd Utils
git clone https://github.com/xztaityozx/cdx
cd cdx
./install.sh

echo "export DISPLAY=localhost:0.0" >> ~/.bashrc
echo "export XMODIFIERS=@im=uim" >> ~/.bashrc
echo "export PS1='\[\033[1;35m\]„¡{\[\e[1;34m\]\u@\H\[\033[1;35m\]}-(\[\e[1;33m\]0\[\033[1;35m\])-{[\[\033[0m\]\t\[\033[1;35m\]]}-{\[\e[1;35m\]\s\[\033[1;35m\]}-{\[\e[1;32m\]\W\[\033[1;35m\]}->>\n„¤{\[\e[1;32m\]his:\[\e[1;33m\]\!\[\033[1;35m\]}-[]-\[\033[1;35m\]}[>>- \[\e[0;39m\]%'" >> ~/.bashrc
echo "cd ~" >> ~/.bashrc
echo "alias c='clear'" >> ~/.bashrc
echo "if [ $SHLVL -eq 1 ]; then
    gnome-terminal -x uim-fep
fi" >> ~/.bashrc


sudo apt install -y ubuntu-gnome-desktop
sudo apt upgrade -y
