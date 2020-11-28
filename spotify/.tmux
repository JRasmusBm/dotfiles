#!/bin/bash

set -e

previous_dir=$(pwd)
cd /home/jrasmusbm/dotfiles/spotify

if ! tmux has-session -t=spotify 2> /dev/null; then
  tmux new-session -d -s spotify -n client -x $(tput cols) -y $(tput lines)
  tmux send-keys -t client "alacritty -e env TERM=screen-256color ~/.cargo/bin/ncspot" Enter

  tmux new-window -n config
  tmux send-keys -t config "vim ./config.toml" Enter
fi

if [ "$INITIATED_EXTERNALLY" = 'true' ]; then
  :
else
  tmux attach -t spotify
fi

cd "$previous_dir"
