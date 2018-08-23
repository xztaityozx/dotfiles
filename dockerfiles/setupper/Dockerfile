FROM ubuntu:latest
RUN apt update && apt upgrade -y
RUN apt install git -y
RUN git clone https://github.com/xztaityozx/dotfiles
RUN cd dotfiles
RUN chmod +x setup.sh
RUN setup.sh

CMD bash
