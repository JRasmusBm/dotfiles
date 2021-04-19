" Import {{{
" Default {{{
inoremap <buffer> <leader>id import <++> from "<++>";
      \<++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" React {{{
inoremap <buffer> <leader>ir import React from "react";
"}}}
" All {{{
inoremap <buffer> <leader>ia import * as <++> from "<++>";
      \<++>:call jrasmusbm#snippets#backward_marker(3)
"}}}
" Named {{{
inoremap <buffer> <leader>in import { <++> } from "<++>";
      \<++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Module {{{
inoremap <buffer> <leader>im import "<++>";
      \<++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Component {{{
inoremap <buffer> <leader>ic import <++> from "components/<++>";<++>
  \:call jrasmusbm#snippets#backward_marker(2)
"}}}
"}}}

" Export {{{
" Specify {{{
inoremap <buffer> <leader>ex export <++> <++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Named {{{
inoremap <buffer> <leader>en <++>O}O	<++>Oexport {:call jrasmusbm#snippets#forward_marker(1)
"}}}
" Default {{{
inoremap <buffer> <leader>ed <++>Oexport default <++> ;:call jrasmusbm#snippets#backward_marker(1)
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
      \}:call jrasmusbm#snippets#backward_marker(1)
" }}}
" }}}

" Witchcraft {{{
" File {{{
inoremap <buffer> <leader>wf // @include "./utils/addAttributes.js"
      \S
      \(function <++>() {
      \setInterval(() => {
      \<++>
      \}, 1000)
      \})():call jrasmusbm#snippets#backward_marker(2)
" }}}
" Button {{{
inoremap <buffer> <leader>wb addAttributes({
     \query: "<++>",
     \  attributes: { role: "button" },
     \});
     \<++>:call jrasmusbm#snippets#backward_marker(2)
" }}}
" }}}

" React {{{
" Styled {{{
inoremap <buffer> <leader>rs const <++> = styled.<++>`<++>`<++>:call jrasmusbm#snippets#backward_marker(4)
"}}}
" Component {{{
inoremap <buffer> <leader>rc const <++> = () => {<++>}<++>:call jrasmusbm#snippets#backward_marker(3)
"}}}
" File {{{
inoremap <buffer> <leader>rf import React from "react";
      \const <++> = () => {
      \return <++>;
      \}
      \export default <++>;:call jrasmusbm#snippets#backward_marker(3)
"}}}
"}}}

" Router {{{
" Endpoint {{{
inoremap <buffer> <leader>re router.get("<++>", (req, res) => {
      \<++>
      \}):call jrasmusbm#snippets#backward_marker(2)
" }}}
" }}}

" Reducer {{{
" Reducer {{{
inoremap <buffer> <leader>rr const reducer = (state, action) => {
      \switch (action.type) {
      \case <++>:
      \return produce(state, draftState => {
      \<++>
      \})
      \<++>
      \default:
      \return state
      \}
      \}:call jrasmusbm#snippets#backward_marker(3)
" }}}
" Action {{{
inoremap <buffer> <leader>ra case <++>:
      \return produce(state, draftState => {
      \<++>
      \})
      \<++>:call jrasmusbm#snippets#backward_marker(3)
" }}}
" }}}

" Object {{{
" Field {{{
inoremap <buffer> <leader>of <++>: <++>,<++>:call jrasmusbm#snippets#backward_marker(3)
"}}}
"}}}

" Logging {{{
" Format {{{
inoremap <buffer> <leader>lf JSON.stringify(<++>, null, 2)<++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Print {{{
inoremap <buffer> <leader>ll console.log(<++>);<++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Error {{{
inoremap <buffer> <leader>le console.error(<++>);
      \<++>:call jrasmusbm#snippets#backward_marker(2)
" }}}
" Info {{{
inoremap <buffer> <leader>li console.info(<++>);
      \<++>:call jrasmusbm#snippets#backward_marker(2)
" }}}
" Breakpoint {{{
inoremap <buffer> <leader>lb console.log({
      \file: "%",
      \line: =line("."),
      \<++>
      \});:call jrasmusbm#snippets#backward_marker(1)
" }}}
" Mock {{{
inoremap <buffer> <leader>lm console.<++> = jest.fn();
      \console.<++>.mockClear();:call jrasmusbm#snippets#backward_marker(2)
" }}}
"}}}

" Variable {{{
" Let {{{
inoremap <buffer> <leader>vl let <++> = <++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Const {{{
inoremap <buffer> <leader>vc const <++> = <++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Destructuring {{{
inoremap <buffer> <leader>vd const { <++> } = <++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Object {{{
inoremap <buffer> <leader>vo const <++> = {<++>}:call jrasmusbm#snippets#backward_marker(2)
"}}}
"}}}

" Function {{{
" Definition {{{
inoremap <buffer> <leader>fd function <++> (<++>) {<++>}<++><<$:call jrasmusbm#snippets#backward_marker(4)
"}}}
" Inline {{{
inoremap <buffer> <leader>fi (<++>) => <++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Arrow {{{
inoremap <buffer> <leader>fa const <++> = (<++>) => {<++>}<++><<$:call jrasmusbm#snippets#backward_marker(4)
"}}}
" Return {{{
inoremap <buffer> <leader>rt return <++>;<++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
"}}}

" Set {{{
" Timeout {{{
inoremap <buffer> <leader>st setTimeout(() => {
      \<++>
      \}, <++>):call jrasmusbm#snippets#backward_marker(2)
" }}}
" Interval {{{
inoremap <buffer> <leader>si setInterval(() => {
      \<++>
      \}, <++>):call jrasmusbm#snippets#backward_marker(2)
" }}}
" }}}

" Hooks {{{
" Specify {{{
inoremap <buffer> <leader>hh const <++> = use<++>(<++>);<++>:call jrasmusbm#snippets#backward_marker(4)
"}}}
" State {{{
inoremap <buffer> <leader>hs const [<++>, set<++>] = React.useState(<++>);<++>:call jrasmusbm#snippets#backward_marker(4)
"}}}
" Reducer {{{
inoremap <buffer> <leader>hr const [{<++>}, dispatch] = React.useReducer(reducer, {<++>});<++>:call jrasmusbm#snippets#backward_marker(3)
"}}}
" Effect {{{
inoremap <buffer> <leader>he React.useEffect(() => {<++>}, [<++>]);<++>:call jrasmusbm#snippets#backward_marker(3)
"}}}
" Layout {{{
inoremap <buffer> <leader>hl React.useLayoutEffect(() => {<++>}, [<++>]);<++>:call jrasmusbm#snippets#backward_marker(3)
"}}}
" Callback {{{
inoremap <buffer> <leader>hc const <++> = React.useCallback((<++>) => {<++>}, [<++>]);<++>:call jrasmusbm#snippets#backward_marker(5)
"}}}
" Memo {{{
inoremap <buffer> <leader>hm const <++> = React.useMemo((<++>) => {<++>}, [<++>]);<++>:call jrasmusbm#snippets#backward_marker(5)
"}}}
"}}}

" Test {{{
" Before Each {{{
inoremap <buffer> <leader>db beforeEach(async () => {<++>});<++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Tear Down {{{
inoremap <buffer> <leader>dt afterEach(async () => {<++>});<++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Suite {{{
inoremap <buffer> <leader>ds describe("<++>", () => {<++>}) <++><<$:call jrasmusbm#snippets#backward_marker(3)
"}}}
" Patch {{{
inoremap <buffer> <leader>dp jest.mock("<++>")
      \<++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Case {{{
inoremap <buffer> <leader>dc test("- <++>", async () => {
      \// Given
      \S
      \// When
      \S
      \// Then
      \Sthrow "Not implemented!";
      \});
      \<++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" RegExp {{{
inoremap <buffer> <leader>dx expect.stringMatching(/<++>/):call jrasmusbm#snippets#backward_marker(1)
" }}}
" Render {{{
inoremap <buffer> <leader>dr const { <++> } = render(<++>);<++>:call jrasmusbm#snippets#backward_marker(3)
"}}}
" Expect {{{
inoremap <buffer> <leader>de expect(<++>).<++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Wait {{{
inoremap <buffer> <leader>dw await waitFor(() => {<++>});<++>:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Fire Event {{{
inoremap <buffer> <leader>dfe fireEvent.<++>(<++>);:call jrasmusbm#snippets#backward_marker(2)
"}}}
"}}}

" GraphQL {{{
" Tag {{{
inoremap <buffer> <leader>qt const <++> = gql`
      \<++>
      \`<++>:call jrasmusbm#snippets#backward_marker(3)
"}}}
" Resolver {{{
inoremap <buffer> <leader>qr const <++> = async (_parent, _args, _context) => {
      \return <++>
      \}:call jrasmusbm#snippets#backward_marker(2)
" }}}
"}}}

" Control Statement {{{
" If {{{
inoremap <buffer> ;ci if (<++>) {<++>}<++><<:call jrasmusbm#snippets#backward_marker(3)
"}}}
" Ternary {{{
inoremap <buffer> <leader>ct <++> ? <++> : <++>:call jrasmusbm#snippets#backward_marker(3)
" }}}
" Try / Catch {{{
inoremap <buffer> <leader>cts try {
      \<++>
      \} catch (error) {
      \<++>
      \}:call jrasmusbm#snippets#backward_marker(2)
" }}}
" Else {{{
inoremap <buffer> ;ce else {<++>}<++><<:call jrasmusbm#snippets#backward_marker(2)
"}}}
" Elif {{{
inoremap <buffer> ;cei else if (<++>){<++>}<++><<:call jrasmusbm#snippets#backward_marker(3)
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
      \:call jrasmusbm#snippets#backward_marker(5)
"}}}
" Case {{{
inoremap <buffer> <leader>csc case <++>:
      \	<++>
      \break;<<o
      \<++><<
      \:call jrasmusbm#snippets#backward_marker(3)
"}}}
"}}}
" For {{{
" Each {{{
inoremap <buffer> <leader>cfe for(let <++> of <++>) {
  \<++>
  \}
  \<++>:call jrasmusbm#snippets#backward_marker(4)
"}}}
" Index {{{
inoremap <buffer> <leader>cfo for(let i = 0; i < <++>; i++) {
  \<++>
  \}
  \<++>:call jrasmusbm#snippets#backward_marker(3)
"}}}
"}}}
"}}}

" Class {{{
inoremap <buffer> <leader>cd class <++> {<++>}<++>:call jrasmusbm#snippets#backward_marker(3)
"}}}

" JQuery {{{
" Specify {{{
inoremap <buffer> <leader>jq $(<++>).<++>;<++>:call jrasmusbm#snippets#backward_marker(3)
"}}}
" Click {{{
inoremap <buffer> <leader>jc $("<++>").on("click", () => {	<++>});<<o<++>:call jrasmusbm#snippets#backward_marker(3)
"}}}
" Click selector {{{
inoremap <buffer> <leader>jl $(document).on("click", "<++>", () =>{	<++>});<<o<++>:call jrasmusbm#snippets#backward_marker(3)
"}}}
" Import {{{
inoremap <buffer> <leader>ji import $ from "jquery";
"}}}
"}}}

" Arguments {{{
" Named {{{
inoremap <buffer> <leader>an <++>=<++>,<++>:call jrasmusbm#snippets#backward_marker(3)
" }}}
" }}}
