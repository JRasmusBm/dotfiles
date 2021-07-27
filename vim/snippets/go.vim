" Import {{{
" Module {{{
inoremap <buffer> <leader>id import ("<++>")
      \<++>:call bushels#backward_marker(2)
" }}}
" }}}
" File {{{
inoremap <buffer> <leader>gf package main
      \import (
      \"fmt"
      \)
      \func main() {
      \<++>
      \}:call bushels#backward_marker(1)
" }}}
" Function {{{
inoremap <buffer> <leader>fd func <++>() {
  \<++>
  \}
  \<++>:call bushels#backward_marker(3)
"}}}
" Testing {{{
" Expect {{{
inoremap <buffer> <leader>de if <++> {
      \t.Errorf(<++>)
      \}:call bushels#backward_marker(2)
" }}}
" File {{{
inoremap <buffer> <leader>df package <++>
      \import ("testing")
      \func Test<++>(t *testing.T) {<++>}:call bushels#backward_marker(3)
" }}}
" Case {{{
inoremap <buffer> <leader>dc func Test<++>(t *testing.T) {<++>}
      \:call bushels#backward_marker(2)
" }}}
" }}}
" Log {{{
" Standard {{{
inoremap <buffer> <leader>ll fmt.Printf(<++>)
  \<++>:call bushels#backward_marker(2)
"}}}
" }}}
" Control Statements {{{
inoremap <buffer> <leader>ci if <++> {<++>}
  \:call bushels#backward_marker(2)
" }}}
" Types {{{
inoremap <buffer> <leader>ti type <++> interface {
      \<++>
      \}<++>:call bushels#backward_marker(3)
inoremap <buffer> <leader>ts type <++> struct {
      \<++>
      \}<++>:call bushels#backward_marker(3)
" }}}
" Method {{{
" Declaration {{{
function! GetName() abort
  let save_pos = getpos('.')
  norm ?typewyiw
  call setpos('.', save_pos)
endfunction
inoremap <buffer> <leader>md :call GetName()i
      \func (pb~"_C *") <++>(<++>)<Space><++><Space>{<++>}<++>
      \:call bushels#backward_marker(5)
" }}}
" }}}
