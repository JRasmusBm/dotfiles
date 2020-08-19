#!/bin/bash

source ./scripts/install_dependencies.sh

update_system
uninstall_unnecessary_stuff
install_sshd
install_blas
install_python_37
install_virtualenvwrapper
python3.7 ./scripts/symlink.py
install_node
install_zsh
install_tmux
install_nvim
update_system

chsh -s $(which zsh)

