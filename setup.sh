#!/bin/bash


# update
sudo apt update && sudo apt upgrade -y

# get packages
sudo apt install -y git curl zsh wget make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev

# brew
HOMEBREW_FORCE_VENDOR_RUBY=1 sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin

# any packages from brew
brew install fzf pyenv hub ghq go exa gcc zplug bat python@2 python

# go
export GOPATH=$HOME/.go
go get github.com/xztaityozx/go-cdx

# python setup
#eval "$(pyenv init -)"
#CFLAGS="-I$(brew --prefix openssl)/include" LDFLAGS="-L$(brew --prefix openssl)/lib" pyenv install -v 3.6.5
#CFLAGS="-I$(brew --prefix openssl)/include" LDFLAGS="-L$(brew --prefix openssl)/lib" pyenv install -v 2.7.15
#pyenv global 3.6.5 2.7.15

pip3 install --upgrade pip
pip2 install --upgrade pip
pip3 install neovim
pip2 install neovim


# vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# zplug
zplug install

# get some utils
mkdir -p $HOME/.utils && cd $HOME/.utils
wget https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
wget https://raw.githubusercontent.com/denilsonsa/prettyping/master/prettyping
ls -1 | xargs -n1 chmod +x

# some config
ln -s $HOME/.ghq/github.com/xztaityozx/dotfiles/config/* $HOME/.config/


# complete
echo "Complete"
