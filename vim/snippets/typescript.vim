" React {{{
" File {{{
inoremap <buffer> <leader>rf import React from "react";
  \interface Props {
  \<++>}
  \const <++>: React.FC<Props> = (<++>) => {
  \<++>
  \}
  \export default <++>;:call BackwardMarker(5)
"}}}
" Component {{{
inoremap <buffer> <leader>rc interface Props {
      \<++>}
      \const <++>: React.FC<Props> = (<++>) => {
      \<++>
      \}
      \<++>:call BackwardMarker(5)
" }}}
" }}}
" Method {{{
" Declaration {{{
inoremap <buffer> <leader>md <++>: (<++>) => <++> = (<++>) => {
      \<++>return <++>; }
      \<++>:call BackwardMarker(7)
" }}}
" }}}
" Types {{{
" Interface {{{
inoremap <buffer> <leader>if interface <++> {<++>}<++>:call BackwardMarker(3)
" }}}
" }}}
" Imports {{{
" All {{{
inoremap <buffer> <leader>ia <++>Oimport * as <++> from "<++>";:call BackwardMarker(2)
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
            \}):call BackwardMarker(7)
" }}}
" Before Each {{{
inoremap <buffer> <leader>db beforeEach(async (): Promise<void> => {<++>});<++>:call BackwardMarker(2)
" }}}
" Tear Down {{{
inoremap <buffer> <leader>dt afterEach(async (): Promise<void> => {<++>});<++>:call BackwardMarker(2)
" }}}
" Case {{{
inoremap <buffer> <leader>dc test("<++>", async (): Promise<void> => {
      \Sthrow "Not implemented!";
      \})
      \<++><<$:call BackwardMarker(2)
" }}}
" }}}
" Hooks {{{
inoremap <buffer> <leader>he useEffect((): void => {<++>}, [<++>]);<++>:call BackwardMarker(3)
inoremap <buffer> <leader>hl useLayoutEffect((): void => {<++>});<++>:call BackwardMarker(2)
" React Component
" }}}
" Logging {{{
" Mock {{{
inoremap <buffer> <leader>lm console.<++> = jest.fn();
      \;(console.<++> as jest.Mock).mockClear();:call BackwardMarker(2)
" }}}
" }}}
