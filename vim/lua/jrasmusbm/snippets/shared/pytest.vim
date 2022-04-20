" Expect {{{
inoremap <buffer> <leader>de assert <++><++>:call bushels#backward_marker(2)
" Raises {{{
inoremap <buffer> <leader>der with self.assertRaisesRegex(<++>, "<++>"):
      \<++>:call bushels#backward_marker(3)
"}}}
" }}}
