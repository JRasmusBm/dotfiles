#!/bin/bash

set -e

previous_dir=$(pwd)
cd /home/jrasmusbm/dotfiles

if ! tmux has-session -t=dotfiles 2> /dev/null; then
  tmux new-session -d -s dotfiles -n vim -x $(tput cols) -y $(tput lines)

  tmux send-keys -t dotfiles:vim "vim -c GFiles" Enter
  tmux split-window -t dotfiles:vim -h
  tmux send-keys -t dotfiles:vim.right "g l" Enter
  tmux send-keys -t dotfiles:vim.right "g" Enter
  tmux send-keys -t dotfiles:vim.right "gh issue list" Enter
fi

if [ "$INITIATED_EXTERNALLY" = 'true' ]; then
  :
else
  tmux attach -t dotfiles
fi

cd "$previous_dir"
