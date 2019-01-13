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
antigen bundle andrewferrier/fzf-z

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

# Paths
export ANDROID_HOME=$HOME/Android/Sdk
PATH=$PATH:$ANDROID_HOME/tools
PATH=$PATH:$ANDROID_HOME/platform-tools
PATH=$PATH:/opt/gradle/gradle-4.5/bin
PATH=$PATH:$HOME/bin
export PATH="$PATH:/usr/local/go/bin:$HOME/go/bin"
export PATH=$PATH:/home/rasmus/.local/bin
export PATH="${HOME}/.config/yarn/global/node_modules/.bin${PATH:+:${PATH}}"; 

# Virtualenvs
source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Envs

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Set default editor
if type "nvim" &> /dev/null;
then
  export VISUAL="nvim"
  alias "vim"="nvim"
else
  export VISUAL="vim"
fi

export EDITOR="$VISUAL"

d="$HOME/.dircolors"
test -r $d && eval "$(dircolors -b $d)"
# Promptline
source ~/.promptline.sh

stty -ixon

source ~/.z.sh
