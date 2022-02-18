" React {{{
" File {{{
inoremap <buffer> <leader>rf import React from "react";
  \interface Props {
  \<++>}
  \const <++>: React.FC<Props> = (<++>) => {
  \<++>
  \}
  \export default <++>;:call bushels#backward_marker(5)
"}}}
" Component {{{
inoremap <buffer> <leader>rc interface Props {
      \<++>}
      \const <++>: React.FC<Props> = (<++>) => {
      \<++>
      \}
      \<++>:call bushels#backward_marker(5)
" }}}
" }}}
" Method {{{
" Declaration {{{
inoremap <buffer> <leader>md <++>: (<++>) => <++> = (<++>) => {
      \<++>return <++>; }
      \<++>:call bushels#backward_marker(7)
" }}}
" }}}
" Types {{{
" Interface {{{
inoremap <buffer> <leader>if interface <++> {<++>}<++>:call bushels#backward_marker(3)
" }}}
" }}}
" Imports {{{
" All {{{
inoremap <buffer> <leader>ia <++>Oimport * as <++> from "<++>";:call bushels#backward_marker(2)
" }}}
" }}}
" Hooks {{{
inoremap <buffer> <leader>he useEffect((): void => {<++>}, [<++>]);<++>:call bushels#backward_marker(3)
inoremap <buffer> <leader>hl useLayoutEffect((): void => {<++>});<++>:call bushels#backward_marker(2)
" React Component
" }}}
" Logging {{{
" Mock {{{
inoremap <buffer> <leader>lm console.<++> = jest.fn();
      \;(console.<++> as jest.Mock).mockClear();:call bushels#backward_marker(2)
" }}}
" }}}
" Argument {{{
" Typed {{{
inoremap <buffer> <leader>at <++>: <++>,
      \<++>:call bushels#backward_marker(3)
" }}}
" }}}
