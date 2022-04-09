FROM ubuntu:latest

RUN apt update && apt upgrade -y
RUN apt install -y zsh sudo git
ENV DEBIAN_FRONTEND=noninteractive

ARG DOCKER_UID=1000
ARG DOCKER_USER=docker
ARG PASSWD=docker
RUN useradd --create-home --uid ${DOCKER_UID} --shell /bin/zsh -G sudo,root ${DOCKER_USER}
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudors
RUN echo $DOCKER_USER:$PASSWD | chpasswd

USER ${DOCKER_USER}

WORKDIR /home/docker
RUN mkdir -p /home/docker/ghq/github.com/xztaityozx/
WORKDIR /home/docker/ghq/github.com/xztaityozx
RUN git clone https://github.com/xztaityozx/dotfiles
WORKDIR /home/docker/ghq/github.com/xztaityozx/dotfiles

#WORKDIR /home/docker/ghq/github.com/xztaityozx/dotfiles/config/zsh
#RUN mkdir .zinit
#RUN git clone https://github.com/zdharma-continuum/zinit.git .zinit/bin
#RUN echo "source $PWD/.zinit/bin/zinit.zsh" > ~/.zshrc
#RUN echo "autoload -Uz _zinit" >> ~/.zshrc
#RUN echo '(( ${+_comps} )) && _comps[zinit]=_zinit' >> ~/.zshrc
#RUN zsh -c "source ~/.zshrc && zinit light NICHOLAS85/z-a-eval && zinit light NICHOLAS85/z-a-linkbin"

CMD ["zsh","-c","echo docker | sudo -S echo do; zsh install.zsh"]
