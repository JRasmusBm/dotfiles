setlocal foldmethod=marker
let b:ale_fixers = ['brittany', 'hlint']
source ~/.vim/snippets/haskell.vim

packadd! ghcmod-vim

call jrasmusbm#coc#setup_maps()
