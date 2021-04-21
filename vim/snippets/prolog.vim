" Function Definition {{{
inoremap <leader>fd <++>(<++>).<++>:call bushels#backward_marker(3)
"}}}

" Rule {{{
" Definition {{{
inoremap <leader>rd <++>(<++>) :-	<++>.:call bushels#backward_marker(3)
"}}}
" Node {{{
inoremap <leader>rn $i,<++>:call bushels#backward_marker(1)
"}}}
"}}}
