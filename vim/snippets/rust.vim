" Type {{{
" Struct {{{
inoremap <buffer> <leader>ts struct <++> {
    \<++>
    \}
    \<++>:call jrasmusbm#snippets#backward_marker(3)
" }}}
" }}}

" Object {{{
" Field {{{
inoremap <buffer> <leader>of <++>: <++>,
    \<++>:call jrasmusbm#snippets#backward_marker(3)
" }}}
" }}}

" Variable {{{
" Mutable {{{
inoremap <buffer> <leader>vm let mut <++> = <++>;
    \<++>:call jrasmusbm#snippets#backward_marker(3)
" }}}
" Const {{{
inoremap <buffer> <leader>vc let <++> = <++>;
    \<++>:call jrasmusbm#snippets#backward_marker(3)
" }}}
" }}}

" Print {{{
inoremap <buffer> <leader>pr println!(<++>);<++>:call jrasmusbm#snippets#backward_marker(2) 
" }}}

" Import {{{
" Module {{{
inoremap <buffer> <leader>im use <++>;<++>:call jrasmusbm#snippets#backward_marker(2)
" }}}
" }}}

" Function {{{
" Definition {{{
inoremap <buffer> <leader>fd fn <++>(<++>) {
    \<++>
    \}<<o
    \<++>:call jrasmusbm#snippets#backward_marker(4)
" }}}
" }}}

" Control {{{
" If {{{
inoremap <buffer> <leader>ci if <++> {
    \<++>
    \}
    \<++>:call jrasmusbm#snippets#backward_marker(3) 
" }}}
" }}}

" Describe {{{
" Expect {{{
inoremap <buffer> <leader>de assert<++>(<++>);
    \<++>:call jrasmusbm#snippets#backward_marker(3)
" }}}
" Case {{{
inoremap <buffer> <leader>dc #[test]
    \fn <++>() {
    \<++>
    \}
    \<++>:call jrasmusbm#snippets#backward_marker(3)
" }}}
" Suite {{{
inoremap <buffer> <leader>ds #[cfg(test)]
    \mod test {
    \use super::*;
    \#[test]
    \fn <++>() {
    \<++>
    \}
    \<++>
    \}:call jrasmusbm#snippets#backward_marker(3)
" }}}
" }}}

" Export {{{
inoremap <buffer> <leader>ex pub 
" }}}
