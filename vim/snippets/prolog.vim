" Function Definition {{{
inoremap <leader>fd <++>(<++>).<++>:call jrasmusbm#snippets#backward_marker(3)
"}}}

" Rule {{{
" Definition {{{
inoremap <leader>rd <++>(<++>) :-	<++>.:call jrasmusbm#snippets#backward_marker(3)
"}}}
" Node {{{
inoremap <leader>rn $i,<++>:call jrasmusbm#snippets#backward_marker(1)
"}}}
"}}}
