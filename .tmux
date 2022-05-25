#!/bin/bash

set -e

previous_dir=$(pwd)
cd "$DOTFILES"

if ! tmux has-session -t=dotfiles 2> /dev/null; then
    tmux new-session -d -s dotfiles -n run -x "$(tput cols)" -y "$(tput lines)"

    tmux new-window -n vim
    tmux send-keys -t vim "v -c GFiles" Enter

    tmux new-window -n cli
    tmux send-keys -t cli "g" Enter
    tmux send-keys -t cli "g li" Enter
fi

if test ! "$INITIATED_EXTERNALLY" = 'true'; then
  tmux-attach-to-session dotfiles:vim
fi

cd "$previous_dir"
