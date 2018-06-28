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
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN mkdir ~/.config && \
    ln -s ~dotfiles/xztaityozx/config/powerline ~/.config/powerline

CMD zsh

