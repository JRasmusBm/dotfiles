setlocal foldmethod=marker
execute "source $DOTFILES/vim/lua/jrasmusbm/snippets/shared/haskell.vim"

packadd! ghcmod-vim

call jrasmusbm#coc#setup_maps()
