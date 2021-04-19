" Folds {{{
" New {{{
inoremap <buffer> <leader>fo # <++> {{{
      \S<++>
      \# }}}
      \S<++>:call jrasmusbm#snippets#backward_marker(3) 
"}}}
" Selection {{{
nnoremap <buffer> <expr> zf jrasmusbm#folds#fold_selection()
"}}}
"}}}

