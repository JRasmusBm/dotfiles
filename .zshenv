if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
  source "${VIRTUAL_ENV}/bin/activate"
fi
# Aliases
alias "python"="python3"
alias "pip"="pip3"
alias "bashrc"="vim ~/.bashrc"
alias "mkdir"="mkdir -pv"
alias "chr"="google-chrome"
alias "co"="git add --all && git commit"
alias "pgAdmin4"="workon pgadmin4 ; python3.7 ~/.virtualenvs/pgadmin4/lib/python3.7/site-packages/pgadmin4/pgAdmin4.py"
alias "st"="clear; git status"
alias "south-pole"="ssh root@139.59.144.120"
alias "spectest-interp"="~/wabt/bin/spectest-interp"
alias "studio"="/usr/local/android-studio/bin/studio.sh"
alias "translate"="python3 ~/1_programming/active/learning/scraping/wikipedia-translator.py"
alias "update-mouse"="sudo modprobe -r psmouse && sudo modprobe psmouse"
alias "vimrc"="vim ~/.vimrc"
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
alias "zshrc"="vim ~/.zshrc"
alias "zshenv"="vim ~/.zshenv"
function anki() {
  directory=$(pwd)
  file="$directory"/"$1"
  echo File: "$file"
  cd ~/.anki
  pipenv run python anki.py "$file" "$2"
  cd "$directory"
}
