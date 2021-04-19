" React {{{
" File {{{
inoremap <buffer> <leader>rf import React from "react";
  \interface Props {
  \<++>}
  \const <++>: React.FC<Props> = (<++>) => {
  \<++>
  \}
  \export default <++>;:call jrasmusbm#snippets#backward_marker(5)
"}}}
" Component {{{
inoremap <buffer> <leader>rc interface Props {
      \<++>}
      \const <++>: React.FC<Props> = (<++>) => {
      \<++>
      \}
      \<++>:call jrasmusbm#snippets#backward_marker(5)
" }}}
" }}}
" Method {{{
" Declaration {{{
inoremap <buffer> <leader>md <++>: (<++>) => <++> = (<++>) => {
      \<++>return <++>; }
      \<++>:call jrasmusbm#snippets#backward_marker(7)
" }}}
" }}}
" Types {{{
" Interface {{{
inoremap <buffer> <leader>if interface <++> {<++>}<++>:call jrasmusbm#snippets#backward_marker(3)
" }}}
" }}}
" Imports {{{
" All {{{
inoremap <buffer> <leader>ia <++>Oimport * as <++> from "<++>";:call jrasmusbm#snippets#backward_marker(2)
" }}}
" }}}
" Tests {{{
" React File {{{
inoremap <buffer> <leader>dr import React from "react";
            \import { render } from "__testutils__/testing-library";
            \import <++> from "..";
            \describe("<++>", () => {
                \describe("<++>", () => {
                    \let result: ReturnType<typeof render>;
                    \beforeEach((): void => {
                        \result = render(<<++>/><++>);
                    \});
                    \test("<++>", async (): Promise<void> => {<++>})
                \})
            \}):call jrasmusbm#snippets#backward_marker(7)
" }}}
" Before Each {{{
inoremap <buffer> <leader>db beforeEach(async (): Promise<void> => {<++>});<++>:call jrasmusbm#snippets#backward_marker(2)
" }}}
" Tear Down {{{
inoremap <buffer> <leader>dt afterEach(async (): Promise<void> => {<++>});<++>:call jrasmusbm#snippets#backward_marker(2)
" }}}
" Case {{{
inoremap <buffer> <leader>dc test("<++>", async (): Promise<void> => {
      \Sthrow "Not implemented!";
      \})
      \<++><<$:call jrasmusbm#snippets#backward_marker(2)
" }}}
" }}}
" Hooks {{{
inoremap <buffer> <leader>he useEffect((): void => {<++>}, [<++>]);<++>:call jrasmusbm#snippets#backward_marker(3)
inoremap <buffer> <leader>hl useLayoutEffect((): void => {<++>});<++>:call jrasmusbm#snippets#backward_marker(2)
" React Component
" }}}
" Logging {{{
" Mock {{{
inoremap <buffer> <leader>lm console.<++> = jest.fn();
      \;(console.<++> as jest.Mock).mockClear();:call jrasmusbm#snippets#backward_marker(2)
" }}}
" }}}
" Argument {{{
" Typed {{{
inoremap <buffer> <leader>at <++>: <++>,
      \<++>:call jrasmusbm#snippets#backward_marker(3)
" }}}
" }}}
