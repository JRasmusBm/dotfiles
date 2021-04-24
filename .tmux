#!/bin/bash

set -e

previous_dir=$(pwd)
cd /home/jrasmusbm/dotfiles

if ! tmux has-session -t=dotfiles 2> /dev/null; then
    tmux new-session -d -s dotfiles -n run -x $(tput cols) -y $(tput lines)

    tmux new-window -n vim
    tmux send-keys -t vim "vim -c GFiles" Enter

    tmux new-window -n cli
    tmux send-keys -t cli "g l" Enter
    tmux send-keys -t cli "g" Enter
    tmux send-keys -t cli "g li" Enter
fi

if [ "$INITIATED_EXTERNALLY" = 'true' ]; then
  :
else
  tmux attach -t dotfiles
fi

cd "$previous_dir"
