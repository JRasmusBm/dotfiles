autocmd BufRead *.test.* setlocal foldlevel=1
nnoremap <leader>zs :setlocal foldmethod=syntax
nnoremap <leader>zm :setlocal foldmethod=marker

set foldopen=block
set foldopen+=hor
set foldopen+=insert
set foldopen+=percent
set foldopen+=mark
set foldopen+=search
set foldopen+=tag
set foldopen+=undo
set foldopen+=quickfix
set foldclose=""

nnoremap za :call jrasmusbm#folds#toggle_foldopen()
