FROM ubuntu:latest
MAINTAINER xztaityozx

RUN apt update && apt upgrade -y
RUN apt install -y curl git neovim zsh python3-dev python3-pip python-pip python-dev
RUN mkdir ~/dotfiles
RUN git clone https://github.com/xztaityozx/dotfiles ./dotfiles/xztaityozx
RUN git clone https://github.com/wheson/dotfiles ./dotfiles/wheson
RUN git clone https://github.com/eliza0x/nvim ./dotfiles/eliza0x 
RUN git clone https://github.com/zplug/zplug $HOME/.zplug && cp ./dotfiles/xztaityozx/zshrc_minimal ~/.zshrc

RUN pip install --upgrade neovim
RUN pip3 install --upgrade neovim
RUN apt install llvm clang wget -y
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN mkdir ~/.config && \
    ln -s ~dotfiles/xztaityozx/config/powerline ~/.config/powerline
WORKDIR /usr/lib/clang/6.0.0/include/
RUN wget https://gist.githubusercontent.com/reza-ryte-club/97c39f35dab0c45a5d924dd9e50c445f/raw/47ecad34033f986b0972cdbf4636e22f838a1313/stdc++.h 

CMD zsh

