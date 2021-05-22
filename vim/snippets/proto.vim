" Message {{{
inoremap <buffer> <leader>m message <++> {
      \<++>
      \}:call bushels#backward_marker(2)
" }}}

" String {{{
inoremap <buffer> <leader>s string <++> = 0;
      \<++>:call bushels#backward_marker(2)
" }}}
