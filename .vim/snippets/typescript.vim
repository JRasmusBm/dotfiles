inoremap ;rf import * as React from "react";
 \import styled from "styled-components";
 \interface Props {<++>}
 \interface State {<++>}
 \const View = styled.div``;
 \class <++> extends React.Component<Props, State> {
 \render() {
 \return <View />;
 \}
 \}
 \export default <++>;
inoremap ;if interface <++> {<++>}<++>:call BackwardMarker(3)
