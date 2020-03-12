#!/bin/bash

set -e

if tmux has-session -t=dotfiles 2> /dev/null; then
  tmux attach -t dotfiles
  exit
fi

tmux new-session -d -s dotfiles -n vim -x $(tput cols) -y $(tput lines)

tmux send-keys -t dotfiles:vim "vim -c GFiles" Enter
tmux split-window -t dotfiles:vim -h
tmux send-keys -t dotfiles:vim.right "g l" Enter
tmux send-keys -t dotfiles:vim.right "g" Enter
tmux send-keys -t dotfiles:vim.right "gh issue list" Enter

tmux attach -t dotfiles:vim.right
