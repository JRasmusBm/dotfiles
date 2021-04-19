" Markers {{{
" Forward {{{
inoremap <buffer> <leader>fm :call jrasmusbm#snippets#forward_marker(<++>)<++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Backward {{{
inoremap <buffer> <leader>bm :call jrasmusbm#snippets#backward_marker(<++>)<++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
"}}}

" Folds {{{
" New {{{
inoremap <buffer> <leader>fo " <++> {{{
      \S<++>
      \" }}}
      \S<++>:call jrasmusbm#snippets#backward_marker(3) 
"}}}
" Selection {{{
nnoremap <buffer> <expr> zf jrasmusbm#folds#fold_selection()
"}}}
"}}}

" Control {{{
" If {{{
inoremap <buffer> <leader>ci if <++>
      \<++>
      \endif:call jrasmusbm#snippets#backward_marker(2)
"}}}
" }}}


" Snippet {{{
inoremap <buffer> <leader>sn inoremap <buffer> <lt>leader><++> <++>:call jrasmusbm#snippets#backward_marker(2)
"}}}

" Plugin {{{
inoremap <buffer> <leader>pl Plug '+'<++>:call jrasmusbm#snippets#backward_marker(1)
"}}}

" Function {{{
" Declaration {{{
inoremap <buffer> <leader>fd function! <++>() abort<++>endfunction<++>:call jrasmusbm#snippets#backward_marker(3) 
"}}}
"}}}

" Import {{{
" Snippet {{{
inoremap <buffer> <leader>is source ~/.vim/snippets/<++>
  \<++>:call jrasmusbm#snippets#backward_marker(2)
" }}}
" }}}
