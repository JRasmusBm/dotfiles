# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Antigen

source /home/rasmus/.zsh/antigen.zsh

# Load the oh-my-zsh's library.
 antigen use oh-my-zsh

# # Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found

# Other Bundles
antigen bundle colored-man-pages
antigen bundle chrissicool/zsh-256color

# # Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# diff-so-fancy
antigen bundle zdharma/zsh-diff-so-fancy

# # Tell Antigen that you're done.
antigen apply

# Vim mode
bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}$(current_branch) $EPS1"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Plugins
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^ ' autosuggest-accept



# WebAssembly
source ~/emsdk/emsdk_set_env.sh

# Set default editor
export VISUAL=vim
export EDITOR="$VISUAL"

# Aliases
alias "chr"="google-chrome"
alias "commit"="git add --all && git commit"
alias "co"="git add --all && git commit"
alias "vimrc"="vim ~/.vimrc"
alias "bashrc"="vim ~/.bashrc"
alias "zshrc"="vim ~/.zshrc"
alias "active"="cd ~/1_programming/active/"
alias "studio"="/usr/local/android-studio/bin/studio.sh"
alias "app"="cd ~/1_programming/active/Spendy/"
alias "wheretrip"="cd ~/2_school/3_y/wheretrip/"
alias "wython"="cd ~/2_school/3_y/wython/"
alias "security"="cd ~/2_school/3_y/network_security/"
alias "probability"="cd ~/2_school/3_y/probability_and_statistics/"
alias "systems"="cd ~/2_school/3_y/systems_and_control/"
alias "spectest-interp"="~/wabt/bin/spectest-interp"
alias "wabt-unittests"="~/wabt/bin/wabt-unittests"
alias "wasm2c"="~/wabt/bin/wasm2c"
alias "wasm2wat"="~/wabt/bin/wasm2wat"
alias "wasm-interp"="~/wabt/bin/wasm-interp"
alias "wasm-objdump"="~/wabt/bin/wasm-objdump"
alias "wasm-opcodecnt"="~/wabt/bin/wasm-opcodecnt"
alias "wasm-validate"="~/wabt/bin/wasm-validate"
alias "wast2json"="~/wabt/bin/wast2json"
alias "wat2wasm"="~/wabt/bin/wat2wasm"
alias "wat-desugar"="~/wabt/bin/wat-desugar"
alias "testing"="cd ~/2_school/3_y/testing/"
alias "graphics"="cd ~/2_school/3_y/graphics/"
alias "church"="cd ~/5_church/"
alias "jan"="cd ~/3_work/jan/"
alias "ph-frontend"="cd ~/3_work/jan/PhotoHistory/PhotoHistory.Web/js/ph-frontend"
alias "in4303"="cd ~/2_school/3_y/in4303/"
alias "ward-council"="cd ~/5_church/meetings/ward_council"
alias "south-pole"="ssh root@139.59.144.120"

# Paths
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Envs
export ANDROID_HOME=$HOME/Android/Sdk
PATH=$PATH:$ANDROID_HOME/tools
PATH=$PATH:$ANDROID_HOME/platform-tools
PATH=$PATH:/opt/gradle/gradle-4.5/bin
export PATH="${HOME}/.config/yarn/global/node_modules/.bin${PATH:+:${PATH}}"; 

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Promptline
source ~/.shell_prompt.sh
