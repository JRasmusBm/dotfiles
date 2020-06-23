" Import {{{
" Default {{{
inoremap <buffer> <leader>id import <++> from "<++>";
      \<++>:call BackwardMarker(2)
"}}}
" React {{{
inoremap <buffer> <leader>ir import React from "react";
"}}}
" Named {{{
inoremap <buffer> <leader>in import { <++> } from "<++>";
      \<++>:call BackwardMarker(2)
"}}}
" Module {{{
inoremap <buffer> <leader>im import "<++>";
      \<++>:call BackwardMarker(2)
"}}}
" Component {{{
inoremap <buffer> <leader>ic import <++> from "components/<++>";<++>
  \:call BackwardMarker(2)
"}}}
"}}}

" Export {{{
" Specify {{{
inoremap <buffer> <leader>ex export <++> <++>:call BackwardMarker(2)
"}}}
" Named {{{
inoremap <buffer> <leader>en <++>O}O	<++>Oexport {:call ForwardMarker(1)
"}}}
" Default {{{
inoremap <buffer> <leader>ed <++>Oexport default <++> ;:call BackwardMarker(1)
"}}}
"}}}

" ServiceWorker {{{
" File {{{
inoremap <buffer> <leader>sf "use strict";
      \const version = <++>;
      \self.addEventListener("install", onInstall);
      \self.addEventListener("activate", onActivate);
      \main().catch(console.error);
      \/* ***************************** */
      \async function main() {
      \console.log(`Service Worker (${version}) starting...`);
      \}
      \async function onInstall(event) {
      \console.log(`Service Worker (${version}) installed...`);
      \self.skipWaiting();
      \}
      \function onActivate(event) {
      \event.waitUntil(handleActivation());
      \}
      \async function handleActivation() {
      \await clients.claim();
      \console.log(`Service Worker (${version}) activated...`);
      \}:call BackwardMarker(1)
" }}}
" }}}

" React {{{
" Styled {{{
inoremap <buffer> <leader>rs const <++> = styled.<++>`<++>`<++>:call BackwardMarker(4)
"}}}
" Component {{{
inoremap <buffer> <leader>rc const <++> = () => {<++>}<++>:call BackwardMarker(3)
"}}}
" Render {{{
inoremap <buffer> <leader>rr <++>O}O	<++>O
      \render() {:call ForwardMarker(2)
"}}}
" File {{{
inoremap <buffer> <leader>rf import * as React from "react";
 \import styled from "styled-components";
 \const View = styled.div``;
 \class <++> extends React.Component {
 \render() {
 \return <View />;
 \}
 \}
 \export default <++>;:call BackwardMarker(2)
"}}}
"}}}

" Object {{{
" Field {{{
inoremap <buffer> <leader>of <++>: <++>,<++>:call BackwardMarker(3)
"}}}
"}}}

" Logging {{{
" Format {{{
inoremap <buffer> <leader>lf JSON.stringify(<++>, null, 2)<++>:call BackwardMarker(2)
"}}}
" Print {{{
inoremap <buffer> <leader>ll console.log(<++>);<++>:call BackwardMarker(2)
"}}}
" Error {{{
inoremap <buffer> <leader>le console.error(<++>);
      \<++>:call BackwardMarker(2)
" }}}
" Info {{{
inoremap <buffer> <leader>li console.info(<++>);
      \<++>:call BackwardMarker(2)
" }}}
"}}}

" Variable {{{
" Let {{{
inoremap <buffer> <leader>vl let <++> = <++>:call BackwardMarker(2)
"}}}
" Const {{{
inoremap <buffer> <leader>vc const <++> = <++>:call BackwardMarker(2)
"}}}
" Destructuring {{{
inoremap <buffer> <leader>vd const { <++> } = <++>:call BackwardMarker(2)
"}}}
" Object {{{
inoremap <buffer> <leader>vo const <++> = {<++>}:call BackwardMarker(2)
"}}}
"}}}

" Function {{{
" Definition {{{
inoremap <buffer> <leader>fd function <++> (<++>) {<++>}<++><<$:call BackwardMarker(4)
"}}}
" Inline {{{
inoremap <buffer> <leader>fi (<++>) => <++> <++>:call BackwardMarker(3)
"}}}
" Arrow {{{
inoremap <buffer> <leader>fa const <++> = (<++>) => {<++>}<++><<$:call BackwardMarker(4)
"}}}
" Return {{{
inoremap <buffer> <leader>rt return <++>;<++>:call BackwardMarker(2)
"}}}
"}}}

" Hooks {{{
" Specify {{{
inoremap <buffer> <leader>hh const <++> = use<++>(<++>);<++>:call BackwardMarker(4)
"}}}
" State {{{
inoremap <buffer> <leader>hs const [<++>, set<++>] = useState(<++>);<++>:call BackwardMarker(4)
"}}}
" Reducer {{{
inoremap <buffer> <leader>hr const [{<++>}, dispatch] = useReducer(reducer, {<++>});<++>:call BackwardMarker(3)
"}}}
" Effect {{{
inoremap <buffer> <leader>he useEffect(() => {<++>}, [<++>]);<++>:call BackwardMarker(3)
"}}}
" Layout {{{
inoremap <buffer> <leader>hl useLayoutEffect(() => {<++>}, [<++>]);<++>:call BackwardMarker(3)
"}}}
" Callback {{{
inoremap <buffer> <leader>hc const <++> = useCallback((<++>) => {<++>}, [<++>]);<++>:call BackwardMarker(5)
"}}}
" Memo {{{
inoremap <buffer> <leader>hm const <++> = useMemo((<++>) => {<++>}, [<++>]);<++>:call BackwardMarker(5)
"}}}
"}}}

" Test {{{
" Before Each {{{
inoremap <buffer> <leader>db beforeEach(async () => {<++>});<++>:call BackwardMarker(2)
"}}}
" Tear Down {{{
inoremap <buffer> <leader>dt afterEach(async () => {<++>});<++>:call BackwardMarker(2)
"}}}
" Suite {{{
inoremap <buffer> <leader>ds describe("<++>", () => {<++>}) <++><<$:call BackwardMarker(3)
"}}}
" Case {{{
inoremap <buffer> <leader>dc test("<++>", async () => {<++>}) <++><<$:call BackwardMarker(3)
"}}}
" Render {{{
inoremap <buffer> <leader>dr const { <++> } = render(<++>);<++>:call BackwardMarker(3)
"}}}
" Expect {{{
inoremap <buffer> <leader>de expect(<++>).<++>:call BackwardMarker(2)
"}}}
" Wait {{{
inoremap <buffer> <leader>dw await wait(() => {<++>});<++>:call BackwardMarker(2)
"}}}
" Fire Event {{{
inoremap <buffer> <leader>dfe fireEvent.<++>(<++>);:call BackwardMarker(2)
"}}}
"}}}

" GraphQL Tag {{{
inoremap <buffer> <leader>qt const <++> = gql`
      \<++>
      \`<++>:call BackwardMarker(3)
"}}}

" Control Statement {{{
" If {{{
inoremap <buffer> ;ci if (<++>) {<++>}<++><<:call BackwardMarker(3)
"}}}
" Else {{{
inoremap <buffer> ;ce else {<++>}<++><<:call BackwardMarker(2)
"}}}
" Elif {{{
inoremap <buffer> ;cei else if (<++>){<++>}<++><<:call BackwardMarker(3)
"}}}
" Switch {{{
" Statement {{{
inoremap <buffer> <leader>css switch (<++>) {
      \case <++>:
      \	<++>
      \break;
      \<++>
      \}
      \<++><<
      \:call BackwardMarker(5)
"}}}
" Case {{{
inoremap <buffer> <leader>csc case <++>:
      \	<++>
      \break;<<o
      \<++><<
      \:call BackwardMarker(3)
"}}}
"}}}
" For {{{
" Each {{{
inoremap <buffer> <leader>cfe for(let <++> of <++>) {
  \<++>
  \}
  \<++>:call BackwardMarker(4)
"}}}
" Index {{{
inoremap <buffer> <leader>cfo for(let i = 0; i < <++>; i++) {
  \<++>
  \}
  \<++>:call BackwardMarker(3)
"}}}
"}}}
"}}}

" Class {{{
inoremap <buffer> <leader>cd class <++> {<++>}<++>:call BackwardMarker(3)
"}}}

" JQuery {{{
" Specify {{{
inoremap <buffer> <leader>jq $(<++>).<++>;<++>:call BackwardMarker(3)
"}}}
" Click {{{
inoremap <buffer> <leader>jc $("<++>").on("click", () => {	<++>});<<o<++>:call BackwardMarker(3)
"}}}
" Click selector {{{
inoremap <buffer> <leader>jl $(document).on("click", "<++>", () =>{	<++>});<<o<++>:call BackwardMarker(3)
"}}}
" Import {{{
inoremap <buffer> <leader>ji import $ from "jquery";
"}}}
"}}}
