#!/bin/sh

set -e

apt-get update
apt-get upgrade
apt-get install -y \
  curl\
  make \
  build-essential \
  libssl-dev \
  zlib1g-dev \
  libbz2-dev \
  libreadline-dev \
  libsqlite3-dev \
  wget \
  curl \
  llvm \
  libncurses5-dev \
  libncursesw5-dev \
  xz-utils \
  tk-dev

. ./shell/install_python.sh

install_python
install_pipenv

pipenv install
pipenv run python ./install.py
