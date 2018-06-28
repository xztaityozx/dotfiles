FROM xztaityozx/nvim:base
MAINTAINER xztaityozx

RUN apt install llvm clang -y
RUN apt install clang-tools-6.0 -y
RUN ln -s /dotfiles/wheson/.config/nvim ~/.config/
RUN ln -s /usr/bin/clangd-6.0 /usr/bin/clangd

CMD zsh

