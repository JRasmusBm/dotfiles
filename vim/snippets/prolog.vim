" Function Definition {{{
inoremap <leader>fd <++>(<++>).<++>:call BackwardMarker(3)
"}}}

" Rule {{{
" Definition {{{
inoremap <leader>rd <++>(<++>) :-	<++>.:call BackwardMarker(3)
"}}}
" Node {{{
inoremap <leader>rn $i,<++>:call BackwardMarker(1)
"}}}
"}}}
