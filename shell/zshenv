if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
  source "${VIRTUAL_ENV}/bin/activate"
fi
source ~/.install_dependencies
# Aliases
alias "python"="python3"
alias "pip"="pip3"
alias "bashrc"="vim ~/.bashrc"
alias "mkdir"="mkdir -pv"
alias "chr"="google-chrome"
alias "br"="brave-browser"
alias "co"="git add --all && git commit"
alias "pgAdmin4"="workon pgadmin4 ; python3.7 ~/.virtualenvs/pgadmin4/lib/python3.7/site-packages/pgadmin4/pgAdmin4.py"
alias "st"="clear; git status"
alias "south-pole"="ssh root@139.59.144.120"
alias "spectest-interp"="~/wabt/bin/spectest-interp"
alias "studio"="/usr/local/android-studio/bin/studio.sh"
alias "update-mouse"="sudo modprobe -r psmouse && sudo modprobe psmouse"
alias "wabt-unittests"="~/wabt/bin/wabt-unittests"
alias "wasm-interp"="~/wabt/bin/wasm-interp"
alias "wasm-objdump"="~/wabt/bin/wasm-objdump"
alias "wasm-opcodecnt"="~/wabt/bin/wasm-opcodecnt"
alias "wasm-validate"="~/wabt/bin/wasm-validate"
alias "wasm2c"="~/wabt/bin/wasm2c"
alias "wasm2wat"="~/wabt/bin/wasm2wat"
alias "wast2json"="~/wabt/bin/wast2json"
alias "wat-desugar"="~/wabt/bin/wat-desugar"
alias "wat2wasm"="~/wabt/bin/wat2wasm"
alias "trc"="vim ~/.tmux.conf"
alias "vrc"="vim ~/.vimrc"
alias "zrc"="vim ~/.zshrc"
alias "arc"="vim ~/.alacritty.yml"
alias "brc"="vim ~/.bashrc"
alias "zenv"="vim ~/.zshenv"
alias "irc"="vim ~/.install_dependencies"
alias "ta"="tmux-attach"
alias "t"="tmux"

function tmux-attach() {
  tmux attach -t $1 
}

function translate() {
  directory=$(pwd)
  command cd ~/.fun_scraping
  pipenv run python wikipedia-translator.py "$1" "$2"
  command cd "$directory"
}
function anki() {
  directory=$(pwd)
  file="$directory"/"$1"
  echo File: "$file"
  command cd ~/.pyautogui
  pipenv run python anki.py "$file" "$2"
  command cd "$directory"
}

function tmux-start() {
  directory=$(pwd)
  cd ~/.pyautogui
  pipenv run python tmux.py "$1"
  cd "$directory"
}
alias "ts"="tmux-start"
fs() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf --query="$1" --select-1 --exit-0) &&
  tmux switch-client -t "$session"
}
