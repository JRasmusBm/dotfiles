#!/bin/bash

set -e

if tmux has-session -t=spotify 2> /dev/null; then
  tmux attach -t spotify
  exit
fi

tmux new-session -d -s spotify -n client -x $(tput cols) -y $(tput lines)
tmux send-keys -t client "alacritty -e env TERM=screen-256color ~/.cargo/bin/ncspot" Enter

tmux new-window -n config
tmux send-keys -t config "vim ./config.toml" Enter

tmux attach -t spotify:client
