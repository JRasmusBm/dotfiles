" Markers {{{
" Forward {{{
inoremap <buffer> <leader>fm :call bushels#forward_marker(<++>)<++>:call bushels#backward_marker(2)
"}}}
" Backward {{{
inoremap <buffer> <leader>bm :call bushels#backward_marker(<++>)<++>:call bushels#backward_marker(2)
"}}}
"}}}

" Folds {{{
" New {{{
inoremap <buffer> <leader>fo " <++> {{{
      \S<++>
      \" }}}
      \S<++>:call bushels#backward_marker(3) 
"}}}
" Selection {{{
nnoremap <buffer> <expr> zf jrasmusbm#folds#fold_selection()
"}}}
"}}}

" Control {{{
" If {{{
inoremap <buffer> <leader>ci if <++>
      \<++>
      \endif:call bushels#backward_marker(2)
"}}}
" }}}


" Snippet {{{
inoremap <buffer> <leader>sn inoremap <buffer> <lt>leader><++> <++>:call bushels#backward_marker(2)
"}}}

" Plugin {{{
inoremap <buffer> <leader>pl Plug '+'<++>:call bushels#backward_marker(1)
"}}}

" Function {{{
" Declaration {{{
inoremap <buffer> <leader>fd function! <++>() abort<++>endfunction<++>:call bushels#backward_marker(3) 
"}}}
"}}}

" Import {{{
" Snippet {{{
inoremap <buffer> <leader>is source ~/.vim/snippets/<++>
  \<++>:call bushels#backward_marker(2)
" }}}
" }}}
