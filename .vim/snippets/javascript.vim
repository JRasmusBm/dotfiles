" Styled component
" Imports
inoremap <buffer> ;ia <++>Oimport * as <++> from "<++>";:call BackwardMarker(2)
inoremap <buffer> ;ir <++>Oimport * as React from "react";:call ForwardMarker(1)
inoremap <buffer> ;in <++>Oimport { <++> } from "<++>";:call BackwardMarker(2)
inoremap <buffer> ;im <++>Oimport "<++>";:call BackwardMarker(1)

inoremap <buffer> ;id <++>Oimport <++> from "<++>";:call BackwardMarker(2)

" Exports
inoremap <buffer> ;en <++>O}O	<++>Oexport {:call ForwardMarker(1)
inoremap <buffer> ;ed <++>Oexport default <++> ;:call BackwardMarker(1)
" React Component
inoremap <buffer> ;rs const <++> = styled.<++>`<++>`<++>:call BackwardMarker(4) 
inoremap <buffer> ;rc <++>O}O	<++>O
      \class <++> extends React.Component {:call BackwardMarker(1)
inoremap <buffer> ;rr <++>O}O	<++>O
      \render() {:call ForwardMarker(2)
inoremap <buffer> ;rf import * as React from "react";
 \import styled from "styled-components";
 \const View = styled.div``;
 \class <++> extends React.Component {
 \render() {
 \return <View />;
 \}
 \}
 \export default <++>;:call BackwardMarker(2)
inoremap <buffer> ;of <++>: <++>,<++>:call BackwardMarker(3) 
inoremap <buffer> ;cu const {<++> } = <++>;<++>:call BackwardMarker(3) 
inoremap <buffer> ;pp JSON.stringify(<++>, null, 2)<++>:call BackwardMarker(2)
inoremap <buffer> ;pr console.log(<++>);<++>:call BackwardMarker(2) 
inoremap <buffer> ;vd const <++> = <++>:call BackwardMarker(2)
inoremap <buffer> ;fd function <++> (<++>) {<++>}<++><<$:call BackwardMarker(4)
inoremap <buffer> ;hs const [<++>, set<++>] = useState(<++>);<++>:call BackwardMarker(4)
inoremap <buffer> ;hr const [{<++>}, dispatch] = useReducer(reducer, {<++>});<++>:call BackwardMarker(3)
inoremap <buffer> ;hf const <++> = useRef(<++>);<++>:call BackwardMarker(3)
inoremap <buffer> ;he useEffect(() => {<++>}, [<++>]);<++>:call BackwardMarker(3)
inoremap <buffer> ;hl useLayoutEffect(() => {<++>});<++>:call BackwardMarker(2)
inoremap <buffer> ;ex export <++> <++>:call BackwardMarker(2)
inoremap <buffer> ;rt return <++>;<++>:call BackwardMarker(2)

inoremap <buffer> ;db beforeEach(() => {<++>});<++>:call BackwardMarker(2)
inoremap <buffer> ;dt afterEach(() => {<++>});<++>:call BackwardMarker(2)
inoremap <buffer> ;ds describe("<++>", () => {<++>}) <++><<$:call BackwardMarker(3)
inoremap <buffer> ;dc it("<++>", async () => {<++>}) <++><<$:call BackwardMarker(3)

inoremap <buffer> ;jq $(<++>).<++>;<++>:call BackwardMarker(3)
inoremap <buffer> ;jc $("<++>").on("click", () => {	<++>});<<o<++>:call BackwardMarker(3)
inoremap <buffer> ;jl $(document).on("click", "<++>", () =>{	<++>});<<o<++>:call BackwardMarker(3)
inoremap <buffer> ;ji import $ from "jquery";
