" Import {{{
" Module {{{
inoremap <buffer> <leader>im import ("<++>")
      \<++>:call jrasmusbm#snippets#backward_marker(2)
" }}}
" }}}
" File {{{
inoremap <buffer> <leader>fp package <++>
  \<++>:call jrasmusbm#snippets#backward_marker(2)
" }}}
" Function {{{
inoremap <buffer> <leader>fd func <++>() {
  \<++>
  \}
  \<++>:call jrasmusbm#snippets#backward_marker(3)
"}}}
" Testing {{{
" Expect {{{
inoremap <buffer> <leader>de if <++> {
      \t.Errorf(<++>)
      \}:call jrasmusbm#snippets#backward_marker(2)
" }}}
" File {{{
inoremap <buffer> <leader>df package <++>
      \import ("testing")
      \func Test<++>(t *testing.T) {<++>}:call jrasmusbm#snippets#backward_marker(3)
" }}}
" Case {{{
inoremap <buffer> <leader>dc func Test<++>(t *testing.T) {<++>}
      \:call jrasmusbm#snippets#backward_marker(2)
" }}}
" }}}
" Other {{{
" Print {{{
inoremap <buffer> <leader>pr fmt.Printf(<++>)
  \<++>:call jrasmusbm#snippets#backward_marker(2)
" }}}
" }}}
" Control Statements {{{
inoremap <buffer> <leader>ci if <++> {<++>}
  \:call jrasmusbm#snippets#backward_marker(2)
" }}}
" Types {{{
inoremap <buffer> <leader>ti type <++> interface {
      \<++>
      \}<++>:call jrasmusbm#snippets#backward_marker(3)
inoremap <buffer> <leader>ts type <++> struct {
      \<++>
      \}<++>:call jrasmusbm#snippets#backward_marker(3)
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
      \:call jrasmusbm#snippets#backward_marker(5)
" }}}
" }}}
