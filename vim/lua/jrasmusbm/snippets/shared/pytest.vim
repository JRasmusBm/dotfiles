" Expect {{{
inoremap <buffer> <leader>de assert <++>
" Raises {{{
inoremap <buffer> <leader>der with self.assertRaisesRegex(<++>, "<++>"):
      \<++>:call bushels#backward_marker(3)
"}}}
" }}}