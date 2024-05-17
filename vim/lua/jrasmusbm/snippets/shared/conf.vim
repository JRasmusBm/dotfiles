" Folds {{{
" New {{{
inoremap <buffer> <leader>fo # <++> {{{
      \S<++>
      \# }}}
      \S<++>:call bushels#backward_marker(3)
"}}}
" Selection {{{
nnoremap <buffer> <expr> zf lua require("jrasmusbm.folds").fold_selection()
"}}}
"}}}
