" Function{{{
" Definition {{{
inoremap <buffer> <leader>fd function <++>(<++>)
      \<++>
      \end:call bushels#backward_marker(3)
"}}}
"}}}

" Log {{{
" Breakpoint {{{
inoremap <buffer> <leader>lb print(<++>):call bushels#backward_marker(1)
" }}}
" }}}
