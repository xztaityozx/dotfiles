FROM xztaityozx/nvim:base
MAINTAINER xztaityozx

RUN apt install llvm clang -y
WORKDIR /dotfiles/xztaityozx/
CMD pwd
RUN git fetch
RUN git checkout ICPC
RUN ln -s /dotfiles/xztaityozx/config/nvim ~/.config/
WORKDIR ~

CMD zsh

