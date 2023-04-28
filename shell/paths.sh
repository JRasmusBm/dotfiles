#!/bin/sh

_usr='/usr'

if echo "$HOME" | \grep -q 'com.termux' 2> /dev/null ; then
  _usr="$(realpath "$HOME/../usr")"
fi

export DOTFILES="${DOTFILES:-"$HOME/projects/dotfiles"}";
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar";
export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX";
export INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH:-}";

MANPATH=''
MANPATH="$MANPATH:/opt/homebrew/share/man"
MANPATH="$MANPATH:/opt/homebrew/share/man:/usr/share/man"
MANPATH="$MANPATH:/usr/local/share/man"
MANPATH="$MANPATH:/opt/homebrew/share/man"
MANPATH="$MANPATH:::"

export MANPATH

PATH=''
PATH="$_usr/local/sbin"
PATH="$PATH:$_usr/local/bin"
PATH="$PATH:$_usr/sbin"
PATH="$PATH:$_usr/bin"
PATH="$PATH:/sbin"
PATH="$PATH:/bin"
PATH="$PATH:/snap/bin"
PATH="$PATH:$HOMEBREW_PREFIX/bin"
PATH="$PATH:$HOMEBREW_PREFIX/sbin";
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
PATH="$PATH:$FLYCTL_INSTALL/bin"
PATH="$PATH:$HOME/projects/polar/bin"

export PATH=$PATH
