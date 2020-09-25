set tabstop=4
set shiftwidth=4
set softtabstop=4
set spell spelllang=en_us

let b:ale_fixers = ['prettier']

set wrap
set textwidth=80

nnoremap <buffer> j gj
nnoremap <buffer> k gk

source ~/.vim/snippets/markdown.vim

call jrasmusbm#coc#setup_maps()
