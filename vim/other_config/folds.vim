augroup CustomFoldlevel
  autocmd BufRead *.test.* setlocal foldlevel=1
augroup END

nnoremap <leader>zs :setlocal foldmethod=syntax
nnoremap <leader>zm :setlocal foldmethod=marker

set foldopen=all
set foldclose=all

nnoremap za :call jrasmusbm#folds#toggle_foldopen()
