setlocal foldmethod=marker
execute "source $DOTFILES/vim/snippets/haskell.vim"

packadd! ghcmod-vim

call jrasmusbm#coc#setup_maps()
