#!/bin/sh

set -e

install_python() {
  curl https://www.python.org/ftp/python/3.8.0/Python-3.8.0.tgz -o Python-3.8.0.tgz
  tar xvf Python-3.8.0.tgz
  rm Python-3.8.0.tgz
  cd Python-3.8.0
  ./configure --enable-optimizations --with-ensurepip=install
  make -j 8
  make altinstall
  cd ..
  rm -rf Python-3.8.0
}

install_pipenv() {
  python3.8 -m pip install pipenv
}
