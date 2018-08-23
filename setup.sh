#!/bin/bash


# update
sudo apt update && sudo apt upgrade -y

ackages
sudo apt install -y git curl zsh wget make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev

rew
sudo apt install -y linuxbrew-wrapper
yes|brew
export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin

ny packages from brew
brew install fzf pyenv hub ghq go exa gcc zplug


export GOPATH=$HOME/.go
go get github.com/xztaityozx/go-cdx


eval "$(pyenv init -)"
CFLAGS="-I$(brew --prefix openssl)/include" LDFLAGS="-L$(brew --prefix openssl)/lib" pyenv install -v 3.6.5
CFLAGS="-I$(brew --prefix openssl)/include" LDFLAGS="-L$(brew --prefix openssl)/lib" pyenv install -v 2.7.15
pyenv global 3.6.5 2.7.15


pip3 install --upgrade pip
pip2 install --upgrade pip
pip3 install neovim
pip2 install neovim


curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


zplug install

# complete
echo "Complete
