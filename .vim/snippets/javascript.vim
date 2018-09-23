" Styled component
inoremap ;sc <++>O`Oconst <++> = styled.<++>`	<++>:call BackwardMarker(2)
" Imports
inoremap ;ia <++>Oimport * as <++> from "<++>";:call BackwardMarker(1)
inoremap ;ir <++>Oimport * as React from "react";:call ForwardMarker(1)
inoremap ;in <++>Oimport { <++> } from "<++>";:call BackwardMarker(1)

inoremap ;id <++>Oimport <++> from "<++>";:call BackwardMarker(1)

" Exports
inoremap ;en <++>O}O	<++>Oexport {:call ForwardMarker(1)
inoremap ;ed <++>Oexport default <++>;:call BackwardMarker(0)
" React Component
inoremap ;rc <++>O}O	<++>O
      \class <++> extends React.Component {:call BackwardMarker(0)
inoremap ;rr <++>O}O	<++>O
      \render() {:call ForwardMarker(1)
inoremap ;rf import * as React from "react";
 \import styled from "styled-components";
 \const View = styled.div``;
 \class <++> extends React.Component {
 \render() {
 \return <View />;
 \}
 \}
 \export default <++>;
