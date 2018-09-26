" Styled component
inoremap ;sc <++>O`Oconst <++> = styled.<++>`	<++>:call BackwardMarker(3)
" Imports
inoremap ;ia <++>Oimport * as <++> from "<++>";:call BackwardMarker(2)
inoremap ;ir <++>Oimport * as React from "react";:call ForwardMarker(1)
inoremap ;in <++>Oimport { <++> } from "<++>";:call BackwardMarker(2)

inoremap ;id <++>Oimport <++> from "<++>";:call BackwardMarker(2)

" Exports
inoremap ;en <++>O}O	<++>Oexport {:call ForwardMarker(1)
inoremap ;ed <++>Oexport default <++> ;:call BackwardMarker(1)
" React Component
inoremap ;rc <++>O}O	<++>O
      \class <++> extends React.Component {:call BackwardMarker(1)
inoremap ;rr <++>O}O	<++>O
      \render() {:call ForwardMarker(2)
inoremap ;rf import * as React from "react";
 \import styled from "styled-components";
 \const View = styled.div``;
 \class <++> extends React.Component {
 \render() {
 \return <View />;
 \}
 \}
 \export default <++>;:call BackwardMarker(2)
