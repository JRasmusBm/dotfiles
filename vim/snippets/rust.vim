" Type {{{
" Struct {{{
inoremap <buffer> <leader>ts struct <++> {
    \<++>
    \}
    \<++>:call BackwardMarker(3)
" }}}
" }}}
" Object {{{
" Field {{{
inoremap <buffer> <leader>of <++>: <++>,
    \<++>:call BackwardMarker(3)
" }}}
" }}}
" Variable {{{
" Mutable {{{
inoremap <buffer> <leader>vm let mut <++> = <++>;
    \<++>:call BackwardMarker(3)
" }}}
" Const {{{
inoremap <buffer> <leader>vc let <++> = <++>;
    \<++>:call BackwardMarker(3)
" }}}
" }}}
inoremap <buffer> <leader>pr println!(<++>);<++>:call BackwardMarker(2) 

inoremap <buffer> <leader>im use <++>;<++>:call BackwardMarker(2)
