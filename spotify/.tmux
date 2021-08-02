#!/bin/bash

set -e

previous_dir=$(pwd)
cd "$DOTFILES/spotify"

if ! tmux has-session -t=spotify 2> /dev/null; then
  tmux new-session -d -s spotify -n client -x "$(tput cols)" -y "$(tput lines)"
  tmux send-keys -t client "alacritty -e env TERM=screen-256color ~/.cargo/bin/ncspot" Enter
fi

if test ! "$INITIATED_EXTERNALLY" = 'true'; then
  ta spotify:client
fi

cd "$previous_dir"
