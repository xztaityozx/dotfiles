FROM ubuntu:latest
MAINTAINER xztaityozx

RUN apt update && apt upgrade -y
RUN apt install -y curl git neovim zsh python3-dev python3-pip python-pip python-dev
RUN mkdir ~/dotfiles && cd ~/dotfiles &&
    git clone https://github.com/xztaityozx/dotfiles ./xztaityozx &&
    git clone https://github.com/wheson/dotfiles ./wheson &&
    git clone https://github.com/eliza0x/nvim ./eliza0x


CMD bash
