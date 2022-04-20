" Image {{{
inoremap <buffer> <leader>df FROM <++>:<++>
  \<++>:call bushels#backward_marker(3)
" }}}
" COPY {{{
inoremap <buffer> <leader>co COPY <++> <++>
  \<++>:call bushels#backward_marker(3)
" }}}
