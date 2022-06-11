#!/bin/bash

set -e

cd "$DOTFILES/spotify"
session_name='spotify'

if ! tmux has-session -t="$session_name" 2> /dev/null; then
  tmux new-session -d -s "$session_name" -n client -x "$(tput cols)" -y "$(tput lines)"
  tmux send-keys -t "$session_name" "alacritty --title spotify -e env TERM=screen-256color ~/.cargo/bin/ncspot" Enter
fi

if test ! "$INITIATED_EXTERNALLY" = 'true'; then
  tmux-attach-to-session "$session_name:client"
fi
