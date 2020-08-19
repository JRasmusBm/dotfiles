FROM ubuntu:20.04

WORKDIR /scripts

RUN apt-get update && \
      apt-get -y install sudo

ENV LD_LIBRARY_PATH=/lib:/usr/lib:/usr/local/lib
ENV TZ=Europe/Stockholm

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN adduser --disabled-password --gecos '' docker
RUN adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER docker

COPY ./vim/vimrc /root/.vimrc
COPY ./vim /root/.vim
COPY ./vim/init.vim /root/nvim/init.vim

COPY ./scripts/install_dependencies.sh .
COPY ./scripts/install_server.sh .
COPY ./scripts/install_all.sh .
COPY ./scripts/install_workstation.sh .

RUN bash ./install_all.sh

ENV PATH=/bin:/usr/bin:/usr/local/bin:/home/docker/.local/bin:$HOME/.local/bin
COPY ./scripts/requirements-dev.txt .
COPY ./scripts/tests .
