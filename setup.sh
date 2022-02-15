#!/bin/sh

set -ex

export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

sh ./install_dependencies/git
sh ./install_dependencies/pyenv

pyenv install '3.10.0'
pyenv global '3.10.0'
