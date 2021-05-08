setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal spell spelllang=en_us

let b:ale_fixers = ['prettier']

setlocal wrap
setlocal textwidth=80

nnoremap <buffer> j gj
nnoremap <buffer> k gk

source ~/.vim/snippets/markdown.vim

call jrasmusbm#coc#setup_maps()
