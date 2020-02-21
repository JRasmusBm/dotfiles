" React {{{
" File {{{
inoremap <buffer> <leader>rf import * as React from "react";
 \import styled from "styled-components";
 \interface Props {<++> }o}
 \interface State {<++> }o}
 \const View = styled.div``;
 \class <++> extends React.Component<Props, State> {
 \render() {
 \return <View />;o
 \}
 \}
 \export default <++>;:call BackwardMarker(4)
"}}}
" Component {{{
inoremap <buffer> <leader>rc interface Props {<++>}const <++>: React.FC<Props> = (<++>) => {<++>}<++>:call BackwardMarker(5)
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
" File {{{
inoremap <buffer> <leader>df import React from "react";
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
inoremap <buffer> <leader>db beforeEach((): void => {<++>});<++>:call BackwardMarker(2)
" }}}
" Tear Down {{{
inoremap <buffer> <leader>dt afterEach((): void => {<++>});<++>:call BackwardMarker(2)
" }}}
" Case {{{
inoremap <buffer> <leader>dc test("<++>", async (): Promise<void> => {<++>}) <++><<$:call BackwardMarker(3)
" }}}
" Render {{{
inoremap <buffer> <leader>dr let result: ReturnType<typeof render>;
" }}}
" }}}
" Hooks {{{
inoremap <buffer> <leader>he useEffect((): void => {<++>}, [<++>]);<++>:call BackwardMarker(3)
inoremap <buffer> <leader>hl useLayoutEffect((): void => {<++>});<++>:call BackwardMarker(2)
" React Component
" }}}
