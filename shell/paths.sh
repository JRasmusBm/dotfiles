#!/bin/sh

_usr='/usr'

if echo "$HOME" | \grep -q 'com.termux' 2>/dev/null; then
  _usr="$(realpath "$HOME/../usr")"
fi

export DOTFILES="${DOTFILES:-"$HOME/projects/dotfiles"}"
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"
export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX"
export INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH-}"

MANPATH=''
MANPATH="$MANPATH:/opt/homebrew/share/man"
MANPATH="$MANPATH:/opt/homebrew/share/man:/usr/share/man"
MANPATH="$MANPATH:/usr/local/share/man"
MANPATH="$MANPATH:/opt/homebrew/share/man"
MANPATH="$MANPATH:::"

export MANPATH

PATH=''
PATH="$_usr/local/sbin"
PATH="$PATH:$HOMEBREW_PREFIX/bin"
PATH="$PATH:$HOMEBREW_PREFIX/sbin"
PATH="$PATH:$_usr/local/bin"
PATH="$PATH:$_usr/sbin"
PATH="$PATH:$_usr/bin"
PATH="$PATH:/sbin"
PATH="$PATH:/bin"
PATH="$PATH:$HOME/.local/share/nvim/mason/bin"
PATH="$PATH:/snap/bin"
PATH=$PATH:/opt/homebrew/opt/coreutils/libexec/gnubin
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
PATH="$PATH:$HOME/bin"
PATH="$PATH:$HOME/.rover/bin"
PATH="$PATH:$FLYCTL_INSTALL/bin"
PATH="$PATH:$HOME/projects/polar/bin"
PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$JAVA_HOME/bin

# Put nvm's default node bin on PATH eagerly so child processes
# (scripts in PATH, git's pager, etc.) can find node/npm/yarn — the
# lazy nvm shell functions only cover commands typed interactively.
# nvm.sh itself stays lazily loaded (see zshrc). Resolves an exact
# version (v21.7.3) or a major-prefix alias (21 -> newest v21.*);
# exotic aliases like lts/* aren't resolved here.
if [ -d "$HOME/.nvm/versions/node" ]; then
  _nvm_def="$(cat "$HOME/.nvm/alias/default" 2>/dev/null)"
  _nvm_bin=""
  if [ -d "$HOME/.nvm/versions/node/v$_nvm_def/bin" ]; then
    _nvm_bin="$HOME/.nvm/versions/node/v$_nvm_def/bin"
  else
    for _d in "$HOME/.nvm/versions/node/v$_nvm_def"*/bin; do
      [ -d "$_d" ] && _nvm_bin="$_d"   # shell-sorted; last match = newest
    done
  fi
  [ -n "$_nvm_bin" ] && PATH="$_nvm_bin:$PATH"
  unset _nvm_def _nvm_bin _d
fi

# pyenv shims must come first so its python/pip win over the system
# ones (equivalent to `pyenv init --path`). Harmless if pyenv absent.
PATH="$HOME/.pyenv/shims:$HOME/.pyenv/bin:$PATH"

export PATH=$PATH
