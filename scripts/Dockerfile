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

COPY ./install_dependencies.sh .
COPY ./install_server.sh .
COPY ./install_all.sh .
COPY ./install_workstation.sh .

RUN bash ./install_all.sh

ENV PATH=/bin:usr/bin:/usr/local/bin:/home/docker/.local/bin
COPY ./requirements-dev.txt .
COPY tests .
