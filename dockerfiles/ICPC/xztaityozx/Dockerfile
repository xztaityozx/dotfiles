FROM xztaityozx/nvim:base
MAINTAINER xztaityozx

RUN apt install llvm clang -y
RUN ln -s /dotfiles/xztaityozx/config/nvim ~/.config/
WORKDIR /dotfiles/xztaityozx/
RUN git checkout ICPC

CMD zsh

