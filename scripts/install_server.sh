#!/bin/bash

source ./scripts/install_dependencies.sh

update_system
install_blas
install_python_37
install_virtualenvwrapper
sh scripts/symlink
install_node
install_zsh
install_tmux
install_nvim
update_system

chsh -s $(which zsh)
