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
