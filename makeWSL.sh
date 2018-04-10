#!/bin/bash

sudo apt update && sudo apt upgrade -y
sudo apt-get install build-essential curl file git python-setuptools 

# linuxbrew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
test -d ~/.linuxbrew && PATH="$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$PATH"
test -d /home/linuxbrew/.linuxbrew && PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
test -r ~/.bash_profile && echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >>~/.bash_profile
echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >>~/.profile

# pyenv
brew install bzip2 openssl readline sqlite xz && \
brew install pyenv && \
  echo 'eval "$(pyenv init -)"' >> ~/.bashrc && \
  eval "$(pyenv init -)" && \
  pyenv install 3.6.1 && \
  pyenv install 2.7.12 && \
  pyenv global 3.6.1. 2.7.12 && \
    pip install neovim && \
    pip2 install neovim && \
    pip install --user powerline-status && \
    pip install powerline-gitstatus

# fzf
brew install fzf
echo 'export FZF_DAFAULT_OPTS="--cycle --height=40% --reverse --tac --ansi -1 -0"' >> ~/.profile

# cdx
brew install node && \
  sudo npm i -g node_cdx && \
    echo 'eval "$(cdx_node --init --fuzzy fzf --defopt \"--make --no-output \")"' >> ~/.bashrc
    
# neovim
brew install neovim
ln -s ~/Utils/dotfiles/config/* ~/.config/

# powerline

