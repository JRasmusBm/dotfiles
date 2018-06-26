# Virtualenvs
source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Envs

# Aliases
alias "translate"="python3.6 ~/1_programming/active/learning/scraping/wikipedia-translator.py"
alias "update-mouse"="sudo modprobe -r psmouse && sudo modprobe psmouse"
alias "chr"="google-chrome"
alias "co"="git add --all && git commit"
alias "vimrc"="vim ~/.vimrc"
alias "bashrc"="vim ~/.bashrc"
alias "zshrc"="vim ~/.zshrc"
alias "studio"="/usr/local/android-studio/bin/studio.sh"
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
alias "south-pole"="ssh root@139.59.144.120"

# Paths
export ANDROID_HOME=$HOME/Android/Sdk
PATH=$PATH:$ANDROID_HOME/tools
PATH=$PATH:$ANDROID_HOME/platform-tools
PATH=$PATH:/opt/gradle/gradle-4.5/bin
export PATH="${HOME}/.config/yarn/global/node_modules/.bin${PATH:+:${PATH}}"; 
