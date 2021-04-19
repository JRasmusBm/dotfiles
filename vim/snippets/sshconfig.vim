" Folds {{{
" New {{{
inoremap <buffer> <leader>fo # <++> {{{
      \S<++>
      \# }}}
      \S<++>:call BackwardMarker(3) 
"}}}
" Selection {{{
nnoremap <buffer> <expr> zf jrasmusbm#folds#fold_selection()
"}}}
"}}}

