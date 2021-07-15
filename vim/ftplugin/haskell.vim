setlocal foldmethod=marker
source ~/.vim/snippets/haskell.vim

packadd! ghcmod-vim

call jrasmusbm#coc#setup_maps()
