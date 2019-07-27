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
inoremap <buffer> <leader>if interface <++> {<++>}<++>:call BackwardMarker(3)
inoremap <buffer> <leader>md <++>: (<++>) => <++> = (<++>) => {
      \<++>return <++>; }
      \<++>:call BackwardMarker(7)
" Imports
inoremap <buffer> <leader>ia <++>Oimport * as <++> from "<++>";:call BackwardMarker(2)
" Tests
inoremap <buffer> <leader>db beforeEach((): void => {<++>});<++>:call BackwardMarker(2)
inoremap <buffer> <leader>dt afterEach((): void => {<++>});<++>:call BackwardMarker(2)
inoremap <buffer> <leader>ds describe("<++>", (): void => {<++>}) <++><<$:call BackwardMarker(3)
inoremap <buffer> <leader>dc test("<++>", async (): Promise<void> => {<++>}) <++><<$:call BackwardMarker(3)
" React Hooks
inoremap <buffer> <leader>he useEffect((): void => {<++>}, [<++>]);<++>:call BackwardMarker(3)
inoremap <buffer> <leader>hl useLayoutEffect((): void => {<++>});<++>:call BackwardMarker(2)
" React Component
inoremap <buffer> <leader>rc interface Props {<++>}const <++>: React.FC<Props> = (<++>) => {<++>}<++>:call BackwardMarker(5)
