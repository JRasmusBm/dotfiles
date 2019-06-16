nnoremap <buffer> ;cd :TSDoc
inoremap <buffer> ;rf import * as React from "react";
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
inoremap <buffer> ;if interface <++> {<++>}<++>:call BackwardMarker(3)
inoremap <buffer> ;md <++>: (<++>) => <++> = (<++>) => {
      \<++>return <++>; }
      \<++>:call BackwardMarker(7)
" Imports
inoremap <buffer> ;ia <++>Oimport * as <++> from "<++>";:call BackwardMarker(2)
" Tests
inoremap <buffer> ;db beforeEach((): void => {<++>});<++>:call BackwardMarker(2)
inoremap <buffer> ;dt afterEach((): void => {<++>});<++>:call BackwardMarker(2)
inoremap <buffer> ;ds describe("<++>", (): void => {<++>}) <++><<$:call BackwardMarker(3)
inoremap <buffer> ;dc it("<++>", async (): Promise<void> => {<++>}) <++><<$:call BackwardMarker(3)
" React Hooks
inoremap <buffer> ;he useEffect((): void => {<++>}, [<++>]);<++>:call BackwardMarker(3)
inoremap <buffer> ;hl useLayoutEffect((): void => {<++>});<++>:call BackwardMarker(2)
