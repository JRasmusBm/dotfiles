#!/bin/bash

set -e

folder_path="/home/jrasmusbm/dotfiles/spotify"
session_name="$(tmux-session-name-from-path "$folder_path")"

cd "$folder_path"

if ! tmux has-session -t="$session_name" 2>/dev/null; then
  tmux new-session -d -s "$session_name" -n run -x "$(tput cols)" -y "$(tput lines)"
  tmux send-keys -t "$session_name" "alacritty --title spotify -e env TERM=screen-256color ~/.cargo/bin/ncspot" Enter

  tmux new-window -t "$session_name" -n vim
  tmux send-keys -t "$session_name" "vim -c GFiles" Enter

  tmux new-window -t "$session_name" -n cli
  tmux send-keys -t "$session_name" "g ll" Enter
  tmux send-keys -t "$session_name" "g" Enter
fi

if test "$INITIATED_EXTERNALLY" != 'true'; then
  (
    tmux-attach-to-session "$session_name:vim"
  )
fi

cd -
