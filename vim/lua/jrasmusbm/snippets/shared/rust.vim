" Type {{{
" Struct {{{
inoremap <buffer> <leader>ts struct <++> {
    \<++>
    \}
    \<++>:call bushels#backward_marker(3)
" }}}
" }}}

" Object {{{
" Field {{{
inoremap <buffer> <leader>of <++>: <++>,
    \<++>:call bushels#backward_marker(3)
" }}}
" }}}

" Variable {{{
" Mutable {{{
inoremap <buffer> <leader>vm let mut <++> = <++>;
    \<++>:call bushels#backward_marker(3)
" }}}
" Const {{{
inoremap <buffer> <leader>vc let <++> = <++>;
    \<++>:call bushels#backward_marker(3)
" }}}
" }}}

" Log {{{
" Simple {{{
inoremap <buffer> <leader>ll println!(<++>);<++>:call bushels#backward_marker(2) 
"}}}
" }}}

" Import {{{
" Module {{{
inoremap <buffer> <leader>im use <++>;<++>:call bushels#backward_marker(2)
" }}}
" }}}

" Function {{{
" Definition {{{
inoremap <buffer> <leader>fd fn <++>(<++>) {
    \<++>
    \}<<o
    \<++>:call bushels#backward_marker(4)
" }}}
" }}}

" Control {{{
" If {{{
inoremap <buffer> <leader>ci if <++> {
    \<++>
    \}
    \<++>:call bushels#backward_marker(3) 
" }}}
" While {{{
inoremap <buffer> <leader>cw while <++> {
    \<++>
    \}
    \<++>:call bushels#backward_marker(3) 
" }}}
" Loop {{{
inoremap <buffer> <leader>cl loop {
    \<++>
    \}
    \<++>:call bushels#backward_marker(2) 
" }}}
" Match {{{
inoremap <buffer> <leader>cm match <++> {
    \<++> => <++>,
    \}
    \<++>:call bushels#backward_marker(4) 
" }}}
" Case {{{
inoremap <buffer> <leader>cc <++> => <++>,
    \<++>:call bushels#backward_marker(4) 
" }}}
" Result {{{
inoremap <buffer> <leader>cr match <++> {
    \Ok(<++>) => <++>,
    \Err(<++>) => <++>,
    \}
    \<++>:call bushels#backward_marker(6) 
" }}}
" }}}

" Describe {{{
" Expect {{{
inoremap <buffer> <leader>de assert<++>(<++>);
    \<++>:call bushels#backward_marker(3)
" }}}
" Case {{{
inoremap <buffer> <leader>dc #[test]
    \fn <++>() {
    \<++>
    \}
    \<++>:call bushels#backward_marker(3)
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
    \}:call bushels#backward_marker(3)
" }}}
" }}}

" Export {{{
inoremap <buffer> <leader>ex pub 
" }}}
