" Styled component
inoremap ;sc <++>O`Oconst <++> = styled.<++>`	<++>?<++>2n:noh4s
" Imports
inoremap ;ia <++>Oimport * as <++> from "<++>";?<++>:nohn4s
inoremap ;ir <++>Oimport * as React from "react";/<++>:noh4s
inoremap ;in <++>Oimport { <++> } from "<++>";?<++>n:noh4s
inoremap ;id <++>Oimport <++> from "<++>";?<++>n:noh4s
" Exports
inoremap ;en <++>O}O	<++>Oexport {/<++>:noh4s
inoremap ;ed <++>Oexport default <++>;?<++>:noh4s
" React Component
inoremap ;rc <++>O}O	<++>O
      \class <++> extends React.Component {?<++>:noh4s
inoremap ;rr <++>O}O	<++>O
      \render() {/<++>:noh4s
inoremap ;rf import * as React from "react";
 \import styled from "styled-components";
 \const View = styled.div``;
 \class <++> extends React.Component {
 \render() {
 \return <View />;
 \}
 \}
 \export default <++>;
