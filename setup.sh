# install git
export DOTFILES="$HOME/projects/dotfiles"
export LOCAL_CONFIG="$HOME/.config/jrasmusbm"
git clone git@github.com:JRasmusBm/dotfiles.git "$DOTFILES"
cd "$DOTFILES"
git submodule update --init --recursive
sh ./scripts/symlink
source $HOME/.profile
idep nvim
