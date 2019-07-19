" Styled component
" Imports
inoremap <buffer> <leader>ia <++>Oimport <++> from "<++>";:call BackwardMarker(2)
inoremap <buffer> <leader>ir <++>Oimport React from "react";:call ForwardMarker(1)
inoremap <buffer> <leader>in <++>Oimport { <++> } from "<++>";:call BackwardMarker(2)
inoremap <buffer> <leader>im <++>Oimport "<++>";:call BackwardMarker(1)

inoremap <buffer> <leader>id <++>Oimport <++> from "<++>";:call BackwardMarker(2)

" Exports
inoremap <buffer> <leader>en <++>O}O	<++>Oexport {:call ForwardMarker(1)
inoremap <buffer> <leader>ed <++>Oexport default <++> ;:call BackwardMarker(1)
" React Component
inoremap <buffer> <leader>rs const <++> = styled.<++>`<++>`<++>:call BackwardMarker(4)
inoremap <buffer> <leader>rc <++>O}O	<++>O
      \class <++> extends React.Component {:call BackwardMarker(1)
inoremap <buffer> <leader>rr <++>O}O	<++>O
      \render() {:call ForwardMarker(2)
inoremap <buffer> <leader>rf import * as React from "react";
 \import styled from "styled-components";
 \const View = styled.div``;
 \class <++> extends React.Component {
 \render() {
 \return <View />;
 \}
 \}
 \export default <++>;:call BackwardMarker(2)
inoremap <buffer> <leader>of <++>: <++>,<++>:call BackwardMarker(3)
inoremap <buffer> <leader>cu const {<++> } = <++>;<++>:call BackwardMarker(3)
inoremap <buffer> <leader>pp JSON.stringify(<++>, null, 2)<++>:call BackwardMarker(2)
inoremap <buffer> <leader>pr console.log(<++>);<++>:call BackwardMarker(2)
" Variables
inoremap <buffer> <leader>vv const <++> = <++>:call BackwardMarker(2)
inoremap <buffer> <leader>vd const { <++> } = <++>:call BackwardMarker(2)
inoremap <buffer> <leader>vo const <++> = {<++>}:call BackwardMarker(2)
"Functions
inoremap <buffer> <leader>fd function <++> (<++>) {<++>}<++><<$:call BackwardMarker(4)
inoremap <buffer> <leader>fi (<++>) => <++> <++>:call BackwardMarker(3)
inoremap <buffer> <leader>af const <++> = (<++>) => {<++>}<++><<$:call BackwardMarker(4)
" Hooks
inoremap <buffer> <leader>hs const [<++>, set<++>] = useState(<++>);<++>:call BackwardMarker(4)
inoremap <buffer> <leader>hr const [{<++>}, dispatch] = useReducer(reducer, {<++>});<++>:call BackwardMarker(3)
inoremap <buffer> <leader>hf const <++> = useRef(<++>);<++>:call BackwardMarker(3)
inoremap <buffer> <leader>he useEffect(() => {<++>}, [<++>]);<++>:call BackwardMarker(3)
inoremap <buffer> <leader>hl useLayoutEffect(() => {<++>}, [<++>]);<++>:call BackwardMarker(3)
inoremap <buffer> <leader>hc const <++> = useCallback((<++>) => {<++>}, [<++>]);<++>:call BackwardMarker(5)
inoremap <buffer> <leader>hm const <++> = useMemo((<++>) => {<++>}, [<++>]);<++>:call BackwardMarker(5)
inoremap <buffer> <leader>hh const <++> = use<++>(<++>);<++>:call BackwardMarker(4)
" Export and Return
inoremap <buffer> <leader>ex export <++> <++>:call BackwardMarker(2)
inoremap <buffer> <leader>rt return <++>;<++>:call BackwardMarker(2)
" Tests
inoremap <buffer> <leader>db beforeEach(() => {<++>});<++>:call BackwardMarker(2)
inoremap <buffer> <leader>dt afterEach(() => {<++>});<++>:call BackwardMarker(2)
" Testing
inoremap <buffer> <leader>ds describe("<++>", () => {<++>}) <++><<$:call BackwardMarker(3)
inoremap <buffer> <leader>dc it("<++>", async () => {<++>}) <++><<$:call BackwardMarker(3)
inoremap <buffer> <leader>dr const { <++> } = render(<++>);<++>:call BackwardMarker(3)
inoremap <buffer> <leader>de expect(<++>).<++>:call BackwardMarker(2)
inoremap <buffer> <leader>dw await wait(() => {<++>});<++>:call BackwardMarker(2)
inoremap <buffer> <leader>df fireEvent.<++>(<++>);:call BackwardMarker(2)

inoremap <buffer> <leader>jq $(<++>).<++>;<++>:call BackwardMarker(3)
inoremap <buffer> <leader>jc $("<++>").on("click", () => {	<++>});<<o<++>:call BackwardMarker(3)
inoremap <buffer> <leader>jl $(document).on("click", "<++>", () =>{	<++>});<<o<++>:call BackwardMarker(3)
inoremap <buffer> <leader>ji import $ from "jquery";
