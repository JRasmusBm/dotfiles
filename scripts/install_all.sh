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
  install_python_38
}

install_all
