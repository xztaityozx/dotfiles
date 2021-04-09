FROM ubuntu:latest

RUN apt update && apt upgrade -y
RUN apt install -y zsh sudo git

ARG DOCKER_UID=1000
ARG DOCKER_USER=docker
RUN useradd --create-home --uid ${DOCKER_UID} --shell /bin/bash -G sudo,root ${DOCKER_USER}
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudors

USER ${DOCKER_USER}

WORKDIR /home/docker
RUN mkdir -p /home/docker/ghq/xztaityozx/
WORKDIR /home/docker/ghq/xztaityozx
RUN git clone https://github.com/xztaityozx/dotfiles

WORKDIR /home/docker/ghq/xztaityozx/dotfiles
RUN zsh ./install.zsh

CMD ["zsh"]
