inoremap <buffer> <leader>fm :call ForwardMarker(<++>)<++>:call BackwardMarker(2)
inoremap <buffer> <leader>bm :call BackwardMarker(<++>)<++>:call BackwardMarker(2)
inoremap <buffer> <leader>fl " <++> {{{S<++>" }}}:call BackwardMarker(2) 
inoremap <buffer> <leader>sn inoremap <buffer> <lt>leader><++> <++>:call BackwardMarker(2)
inoremap <buffer> <leader>pl Plug '<++>'<++>:call BackwardMarker(2)
inoremap <buffer> <leader>fd function! <++>() abort<++>endfunction<++>:call BackwardMarker(3) 
