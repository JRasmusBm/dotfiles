" Import {{{
" Default {{{
inoremap <buffer> <leader>id import <++> from "<++>";
      \<++>:call bushels#backward_marker(2)
"}}}
" All {{{
inoremap <buffer> <leader>ia import * as <++> from "<++>";
      \<++>:call bushels#backward_marker(3)
"}}}
" Named {{{
inoremap <buffer> <leader>in import { <++> } from "<++>";
      \<++>:call bushels#backward_marker(2)
"}}}
" Module {{{
inoremap <buffer> <leader>im import "<++>";
      \<++>:call bushels#backward_marker(2)
"}}}
" Component {{{
inoremap <buffer> <leader>ic import <++> from "components/<++>";<++>
      \:call bushels#backward_marker(2)
"}}}
"}}}

" Export {{{
" Specify {{{
inoremap <buffer> <leader>ex export <++> <++>:call bushels#backward_marker(2)
"}}}
" Named {{{
inoremap <buffer> <leader>en <++>O}O	<++>Oexport {:call bushels#forward_marker(1)
"}}}
" Default {{{
inoremap <buffer> <leader>ed <++>Oexport default <++> ;:call bushels#backward_marker(1)
"}}}
"}}}

" Witchcraft {{{
" File {{{
inoremap <buffer> <leader>wf // @include "./utils/addAttributes.js"
      \S
      \(function <++>() {
      \setInterval(() => {
      \<++>
      \}, 1000)
      \})():call bushels#backward_marker(2)
" }}}
" Button {{{
inoremap <buffer> <leader>wb addAttributes({
      \query: "<++>",
      \  attributes: { role: "button" },
      \});
      \<++>:call bushels#backward_marker(2)
" }}}
" }}}

" Object {{{
" Field {{{
inoremap <buffer> <leader>of <++>: <++>,<++>:call bushels#backward_marker(3)
"}}}
"}}}

" Logging {{{
" Format {{{
inoremap <buffer> <leader>lf JSON.stringify(<++>, null, 2)<++>:call bushels#backward_marker(2)
"}}}
" Print {{{
inoremap <buffer> <leader>ll console.log(<++>);<++>:call bushels#backward_marker(2)
"}}}
" Error {{{
inoremap <buffer> <leader>le console.error(<++>);
      \<++>:call bushels#backward_marker(2)
" }}}
" Info {{{
inoremap <buffer> <leader>li console.info(<++>);
      \<++>:call bushels#backward_marker(2)
" }}}
" Breakpoint {{{
inoremap <buffer> <leader>lb console.log({
      \file: "%",
      \line: =line("."),
      \timestamp: Date.now(),
      \<++>
      \});:call bushels#backward_marker(1)
" }}}
" Mock {{{
inoremap <buffer> <leader>lm console.<++> = jest.fn();
      \console.<++>.mockClear();:call bushels#backward_marker(2)
" }}}
"}}}

" Variable {{{
" Let {{{
inoremap <buffer> <leader>vl let <++> = <++>:call bushels#backward_marker(2)
"}}}
" Const {{{
inoremap <buffer> <leader>vc const <++> = <++>:call bushels#backward_marker(2)
"}}}
" Destructuring {{{
inoremap <buffer> <leader>vd const { <++> } = <++>:call bushels#backward_marker(2)
"}}}
" Object {{{
inoremap <buffer> <leader>vo const <++> = {<++>}:call bushels#backward_marker(2)
"}}}
"}}}

" Function {{{
" Definition {{{
inoremap <buffer> <leader>fd function <++> (<++>) {<++>}<++><<$:call bushels#backward_marker(4)
"}}}
" Inline {{{
inoremap <buffer> <leader>fi (<++>) => <++>:call bushels#backward_marker(2)
"}}}
" Arrow {{{
inoremap <buffer> <leader>fa const <++> = (<++>) => {<++>}<++><<$:call bushels#backward_marker(4)
"}}}
" Return {{{
inoremap <buffer> <leader>rt return <++>;<++>:call bushels#backward_marker(2)
"}}}
"}}}

" Set Timeout / Interval {{{
" Timeout {{{
inoremap <buffer> <leader>st setTimeout(() => {
      \<++>
      \}, <++>):call bushels#backward_marker(2)
" }}}
" Interval {{{
inoremap <buffer> <leader>si setInterval(() => {
      \<++>
      \}, <++>):call bushels#backward_marker(2)
" }}}
" }}}

" Test {{{
" Before Each {{{
inoremap <buffer> <leader>db beforeEach(async () => {<++>});<++>:call bushels#backward_marker(2)
"}}}
" Tear Down {{{
inoremap <buffer> <leader>dt afterEach(async () => {<++>});<++>:call bushels#backward_marker(2)
"}}}
" Suite {{{
inoremap <buffer> <leader>ds describe("<++>", () => {<++>}) <++><<$:call bushels#backward_marker(3)
"}}}
" Patch {{{
inoremap <buffer> <leader>dp jest.mock("<++>")
      \<++>:call bushels#backward_marker(2)
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
      \<++>:call bushels#backward_marker(2)
"}}}
" RegExp {{{
inoremap <buffer> <leader>dx expect.stringMatching(/<++>/):call bushels#backward_marker(1)
" }}}
" Render {{{
inoremap <buffer> <leader>dr const { <++> } = render(<++>);<++>:call bushels#backward_marker(3)
"}}}
" Expect {{{
inoremap <buffer> <leader>de expect(<++>).<++>:call bushels#backward_marker(2)
"}}}
" Wait {{{
inoremap <buffer> <leader>dw await waitFor(() => {<++>});<++>:call bushels#backward_marker(2)
"}}}
" Fire Event {{{
inoremap <buffer> <leader>dfe fireEvent.<++>(<++>);:call bushels#backward_marker(2)
"}}}
"}}}

" GraphQL {{{
" Tag {{{
inoremap <buffer> <leader>qt const <++> = gql`
      \<++>
      \`<++>:call bushels#backward_marker(3)
"}}}
" Resolver {{{
inoremap <buffer> <leader>qr const <++> = async (_parent, _args, _context) => {
      \return <++>
      \}:call bushels#backward_marker(2)
" }}}
"}}}

" Control Statement {{{
" If {{{
inoremap <buffer> ;ci if (<++>) {<++>}<++><<:call bushels#backward_marker(3)
"}}}
" Ternary {{{
inoremap <buffer> <leader>ct <++> ? <++> : <++>:call bushels#backward_marker(3)
" }}}
" Try / Catch {{{
inoremap <buffer> <leader>cts try {
      \<++>
      \} catch (error) {
      \<++>
      \}:call bushels#backward_marker(2)
" }}}
" Else {{{
inoremap <buffer> ;ce else {<++>}<++><<:call bushels#backward_marker(2)
"}}}
" Elif {{{
inoremap <buffer> ;cei else if (<++>){<++>}<++><<:call bushels#backward_marker(3)
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
      \:call bushels#backward_marker(5)
"}}}
" Case {{{
inoremap <buffer> <leader>csc case <++>:
      \	<++>
      \break;<<o
      \<++><<
      \:call bushels#backward_marker(3)
"}}}
"}}}
" For {{{
" Each {{{
inoremap <buffer> <leader>cfe for(let <++> of <++>) {
      \<++>
      \}
      \<++>:call bushels#backward_marker(4)
"}}}
" Index {{{
inoremap <buffer> <leader>cfo for(let i = 0; i < <++>; i++) {
      \<++>
      \}
      \<++>:call bushels#backward_marker(3)
"}}}
"}}}
"}}}

" Class {{{
inoremap <buffer> <leader>cd class <++> {<++>}<++>:call bushels#backward_marker(3)
"}}}

" JQuery {{{
" Specify {{{
inoremap <buffer> <leader>jq $(<++>).<++>;<++>:call bushels#backward_marker(3)
"}}}
" Click {{{
inoremap <buffer> <leader>jc $("<++>").on("click", () => {	<++>});<<o<++>:call bushels#backward_marker(3)
"}}}
" Click selector {{{
inoremap <buffer> <leader>jl $(document).on("click", "<++>", () =>{	<++>});<<o<++>:call bushels#backward_marker(3)
"}}}
" Import {{{
inoremap <buffer> <leader>ji import $ from "jquery";
"}}}
"}}}

" Arguments {{{
" Named {{{
inoremap <buffer> <leader>an <++>=<++>,<++>:call bushels#backward_marker(3)
" }}}
" }}}
