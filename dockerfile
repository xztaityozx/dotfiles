FROM ubuntu:latest

RUN apt update && apt upgrade -y
RUN apt install -y zsh sudo git

ARG DOCKER_UID=1000
ARG DOCKER_USER=docker
ARG DOCKER_PASSWORD=docker
RUN useradd -m --uid ${DOCKER_UID} --groups sudo ${DOCKER_USER} \
  && echo ${DOCKER_USER}:${DOCKER_PASSWORD} | chpasswd

USER ${DOCKER_USER}

WORKDIR /home/docker
RUN mkdir -p /home/docker/ghq/xztaityozx/
WORKDIR /home/docker/ghq/xztaityozx
RUN git clone https://github.com/xztaityozx/dotfiles

RUN cd /home/docker/ghq/xztaityozx/dotfiles
RUN zsh ./install.zsh

CMD ["zsh"]
