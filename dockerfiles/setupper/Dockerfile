FROM ubuntu:latest
RUN apt update && apt upgrade -y
RUN apt install git sudo -y
RUN git clone https://github.com/xztaityozx/dotfiles
WORKDIR dotfiles
RUN ls -1l
RUN chmod +x setup.sh

# add sudo user
RUN groupadd -g 1000 developer && \
    useradd  -g      developer -G sudo -m -s /bin/bash xztaityozx && \
    echo 'xztaityozx:hogehoge' | chpasswd

RUN echo 'Defaults visiblepw'             >> /etc/sudoers
RUN echo 'xztaityozx ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER xztaityozx

RUN echo hogehoge | ./setup.sh

CMD bash
