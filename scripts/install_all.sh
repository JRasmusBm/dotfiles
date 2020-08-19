#!/bin/bash

set -e

if test -f ./scripts/install_dependencies.sh; then
  source ./scripts/install_dependencies.sh
else
  source ./install_dependencies.sh
fi

install_all() {
  update_system
  install_python_37
  install_virtualenvwrapper
  install_python_38
  install_node
  install_brave
  install_git_extras
  install_nvim
  setup_neovim_vm
  install_ruby
  update_system
}

install_all
