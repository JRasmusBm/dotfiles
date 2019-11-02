inoremap <buffer> <leader>fm :call ForwardMarker(<++>)<++>:call BackwardMarker(2)
inoremap <buffer> <leader>bm :call BackwardMarker(<++>)<++>:call BackwardMarker(2)
inoremap <buffer> <leader>fo " <++> {{{S<++>" }}}:call BackwardMarker(2) 
inoremap <buffer> <leader>sn inoremap <buffer> <lt>leader><++> <++>:call BackwardMarker(2)
inoremap <buffer> <leader>pl Plug '+'<++>:call BackwardMarker(1)
inoremap <buffer> <leader>fd function! <++>() abort<++>endfunction<++>:call BackwardMarker(3) 
" Import {{{
" Snippet {{{
inoremap <buffer> <leader>is source ~/.vim/snippets/<++>
  \<++>:call BackwardMarker(2)
" }}}
" }}}
