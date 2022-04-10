FROM ubuntu:latest

RUN apt update && apt upgrade -y
ENV DEBIAN_FRONTEND=noninteractive
RUN apt install -y zsh sudo git
RUN apt install -y make build-essential libssl-dev zlib1g-dev \
                   libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
                   libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
                   autoconf bison build-essential libssl-dev \
                   libyaml-dev libreadline6-dev zlib1g-dev \
                   libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev


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
RUN git checkout refactor/zinit
RUN zsh -c "echo docker | sudo -S echo do; zsh install.zsh"

WORKDIR /home/docker/ghq/github.com/xztaityozx/dotfiles/config/zsh
#RUN mkdir .zinit
#RUN git clone https://github.com/zdharma-continuum/zinit.git .zinit/bin
RUN echo "source $PWD/.zinit/bin/zinit.zsh" > ~/.zshrc
RUN echo "autoload -Uz _zinit" >> ~/.zshrc
RUN echo '(( ${+_comps} )) && _comps[zinit]=_zinit' >> ~/.zshrc
ENV PATH="$PATH:$ZPFX/bin"

CMD ["zsh"]
