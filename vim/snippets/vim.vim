" Markers {{{
" Forward {{{
inoremap <buffer> <leader>fm :call ForwardMarker(<++>)<++>:call BackwardMarker(2)
"}}}
" Backward {{{
inoremap <buffer> <leader>bm :call BackwardMarker(<++>)<++>:call BackwardMarker(2)
"}}}
"}}}

" Folds {{{
" New {{{
inoremap <buffer> <leader>fo " <++> {{{S<++>" }}}:call BackwardMarker(2) 
"}}}
" Selection {{{
nnoremap <buffer> <expr> zf FoldSelection()
"}}}
"}}}

" Snippet {{{
inoremap <buffer> <leader>sn inoremap <buffer> <lt>leader><++> <++>:call BackwardMarker(2)
"}}}

" Plugin {{{
inoremap <buffer> <leader>pl Plug '+'<++>:call BackwardMarker(1)
"}}}

" Function {{{
" Declaration {{{
inoremap <buffer> <leader>fd function! <++>() abort<++>endfunction<++>:call BackwardMarker(3) 
"}}}
"}}}

" Import {{{
" Snippet {{{
inoremap <buffer> <leader>is source ~/.vim/snippets/<++>
  \<++>:call BackwardMarker(2)
" }}}
" }}}
