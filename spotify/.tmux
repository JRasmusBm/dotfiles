#!/bin/bash

set -e

folder_path="$DOTFILES/spotify"
session_name="$(tmux-session-name-from-path "$folder_path")"

cd "$folder_path"

if ! tmux has-session -t="$session_name" 2>/dev/null; then
  tmux new-session -d -s "$session_name" -n run -x "$(tput cols)" -y "$(tput lines)"
  tmux send-keys -t "$session_name" "ncspot -c ./config.toml" Enter
fi

if test "$INITIATED_EXTERNALLY" != 'true'; then
  (
    tmux-attach-to-session "$session_name"
  )
fi

cd -
