" Package {{{
inoremap <buffer> <leader>pk package <++>;<++>:call jrasmusbm#snippets#backward_marker(2) 
"}}}

" Import {{{
" Default {{{
inoremap <buffer> <leader>id import <++>;<++>:call jrasmusbm#snippets#backward_marker(2) 
"}}}
"}}}

" Class {{{
" Definition {{{
inoremap <buffer> <leader>cd public class <++> {<++>}<<A<++>:call jrasmusbm#snippets#backward_marker(3)
"}}}
"}}}

" Documentation {{{
" Block {{{
inoremap <buffer> <leader>hb /**<++>/<++>:call jrasmusbm#snippets#backward_marker(2) 
"}}}
" Param {{{
inoremap <buffer> <leader>hp @param <++><++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
"}}}

" Function {{{
" Definition {{{
inoremap <buffer> <leader>fd <++> <++>(<++>) {<++>}<++>:call jrasmusbm#snippets#backward_marker(5)
"}}}
"}}}
