" Package {{{
inoremap <buffer> <leader>pk package <++>;<++>:call BackwardMarker(2) 
"}}}

" Import {{{
" Default {{{
inoremap <buffer> <leader>id import <++>;<++>:call BackwardMarker(2) 
"}}}
"}}}

" Class {{{
" Definition {{{
inoremap <buffer> <leader>cd public class <++> {<++>}<<A<++>:call BackwardMarker(3)
"}}}
"}}}

" Documentation {{{
" Block {{{
inoremap <buffer> <leader>hb /**<++>/<++>:call BackwardMarker(2) 
"}}}
" Param {{{
inoremap <buffer> <leader>hp @param <++><++>:call BackwardMarker(2)
"}}}
"}}}

" Function {{{
" Definition {{{
inoremap <buffer> <leader>fd <++> <++>(<++>) {<++>}<++>:call BackwardMarker(5)
"}}}
"}}}
