#!/bin/sh

set -e

. ./scripts/install_dependencies.sh

update_system
install_python_37
python3.7 ./scripts/symlink.py
install_node
install_zsh
install_tmux
install_nvim
update_system

chsh -s $(which zsh)
