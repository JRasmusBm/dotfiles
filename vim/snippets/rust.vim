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
" Print {{{
inoremap <buffer> <leader>pr println!(<++>);<++>:call BackwardMarker(2) 
" }}}
" Import {{{
" Module {{{
inoremap <buffer> <leader>im use <++>;<++>:call BackwardMarker(2)
" }}}
" }}}
" Function {{{
" Definition {{{
inoremap <buffer> <leader>fd fn <++>(<++>) {
    \<++>
    \}<<o
    \<++>:call BackwardMarker(4)
" }}}
" }}}
" Control {{{
" If {{{
inoremap <buffer> <leader>ci if <++> {
    \<++>
    \}
    \<++>:call BackwardMarker(3) 
" }}}
" }}}
" Describe {{{
" Expect {{{
inoremap <buffer> <leader>de if !<++> {
    \panic!()
    \}
    \<++>:call BackwardMarker(2)
" }}}
" }}}
