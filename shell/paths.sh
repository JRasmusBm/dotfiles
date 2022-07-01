#!/bin/sh

_usr='/usr'

if echo "$HOME" | grep -q 'com.termux' ; then
  _usr="$(realpath "$HOME/../usr")"
fi

PATH="$_usr/local/sbin"
PATH="$PATH:$_usr/local/bin"
PATH="$PATH:$_usr/sbin"
PATH="$PATH:$_usr/bin"
PATH="$PATH:/sbin"
PATH="$PATH:/bin"
PATH="$PATH:/snap/bin"
PATH="$PATH:$_usr/local/go/bin"
PATH="$PATH:$_usr/games"
PATH="$PATH:$_usr/local/games"
PATH="$PATH:$HOME/go/bin"
PATH="$PATH:$HOME/.cargo/bin"
PATH="$PATH:$HOME/.cargo/bin"
PATH="$PATH:$HOME/.cargo/bin"
PATH="$PATH:$HOME/.cabal/bin"
PATH="$PATH:$HOME/.ghcup/bin"
PATH="$PATH:$HOME/.deno/bin"
PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:$HOME/Android/Sdk/tools"
PATH="$PATH:$HOME/Android/Sdk/emulator"
PATH="$PATH:$HOME/Android/Sdk/tools/bin"
PATH="$PATH:$HOME/Android/Sdk/platform-tools"
PATH="$PATH:$HOME/.cache/depot_tools"
PATH="$PATH:$HOME/.dotnet"
PATH="$PATH:$HOME/.fzf/bin"
PATH="$PATH:$HOME/.poetry/bin"
PATH="$PATH:$DOTFILES/bin"
PATH="$PATH:$HOME/.pyenv/bin"
PATH="$PATH:$HOME/.rover/bin"

export PATH=$PATH
