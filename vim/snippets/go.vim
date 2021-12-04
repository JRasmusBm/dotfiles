" Import {{{
" Module {{{
inoremap <buffer> <leader>id import ("<++>")
      \<++>:call bushels#backward_marker(2)
" }}}
" }}}
" Return {{{
inoremap <buffer> <leader>rt return<Space><++>:call bushels#backward_marker(1)
" }}}
" File {{{
inoremap <buffer> <leader>gf package main
      \import (
      \"fmt"
      \)
      \func main() {
      \<++>
      \}:call bushels#backward_marker(1)
" }}}
" Function {{{
inoremap <buffer> <leader>fd func <++>() <++> {
  \<++>
  \}
  \<++>:call bushels#backward_marker(4)
"}}}
" Testing {{{
" Equals {{{
inoremap <buffer> <leader>de if got != want {
      \t.Errorf("got %v want %v", got, want)
      \}
" }}}
" Deep Equals {{{
inoremap <buffer> <leader>ded if !reflect.DeepEqual(got, want) {
      \t.Errorf("got %v want %v", got, want)
      \}
" }}}
" File {{{
inoremap <buffer> <leader>df package <++>
      \import ("testing")
      \func Test<++>(t *testing.T) {<++>}:call bushels#backward_marker(3)
" }}}
" Suite {{{
inoremap <buffer> <leader>ds func Test<++>(t *testing.T) {
      \t.Run("<++>", func(t *testing.T) {
      \got := <++>
      \want := <++>
      \if got != want {
      \t.Errorf("got %v want %v", got, want)
      \}
      \})
      \}:call bushels#backward_marker(4)
" }}}
" Case {{{
inoremap <buffer> <leader>dc t.Run("<++>", func(t *testing.T) {
      \got := <++>
      \want := <++>
      \if got != want {
      \t.Errorf("got %v want %v", got, want)
      \}
      \}):call bushels#backward_marker(3)
" }}}
" Helper {{{
inoremap <buffer> <leader>dh func <++>(t testing.TB, <++>) {
      \t.Helper()
      \<++>
      \}:call bushels#backward_marker(3)
" }}}
" Benchmark {{{
inoremap <buffer> <leader>db func Benchmark<++>(b *testing.B) {
      \<++>
      \}:call bushels#backward_marker(2)
" }}}
" Example {{{
inoremap <buffer> <leader>dx func Example<++>() {
      \<++>
      \}:call bushels#backward_marker(2)
" }}}
" Table Test {{{
inoremap <buffer> <leader>dt t.Run("Table Test", func(t *testing.T) {
      \testTable := []struct {
		  \<++>
		  \want <++>
		  \}{
		  \{ <++> want: <++>},
		  \}
		  \for _, testEntry := range testTable {
		  \got := <++>
		  \if !reflect.DeepEqual(got, want) {
		  \t.Errorf("%#v, got %v want %v", <++>, got, testEntry.want)
		  \}
		  \}:call bushels#backward_marker(6)
"}}}
" }}}
" Log {{{
" Standard {{{
inoremap <buffer> <leader>ll fmt.Printf(<++>)
  \<++>:call bushels#backward_marker(2)
"}}}
" Format {{{
inoremap <buffer> <leader>lf fmt.Sprintf(<++>):call bushels#backward_marker(2)
" }}}
" }}}
" Control Statements {{{
" If {{{
inoremap <buffer> <leader>ci if <++> {<++>}
  \:call bushels#backward_marker(2)
"}}}
" Switch Statement {{{
inoremap <buffer> <leader>cs switch <++> {
      \case <++>:
      \<++>
      \}:call bushels#backward_marker(3)
" }}}
" Switch Case {{{
inoremap <buffer> <leader>cc o
      \case <++>:
      \<++>:call bushels#backward_marker(2)
" }}}
" Switch Default {{{
inoremap <buffer> <leader>cd o
      \default:
      \<++>:call bushels#backward_marker(1)
" }}}
" For loop {{{
inoremap <buffer> <leader>cfo for i := 0; i < <++>; i++ {
      \<++>
      \}:call bushels#backward_marker(2)
" }}}
" For each {{{
inoremap <buffer> <leader>cfe for _, <++> := range <++> {
      \<++>
      \}:call bushels#backward_marker(3)
" }}}
" }}}
" Types {{{
" Interface {{{
inoremap <buffer> <leader>ti type <++> interface {
      \<++>
      \}<++>:call bushels#backward_marker(3)
"}}}
" Struct {{{
inoremap <buffer> <leader>ts type <++> struct {
      \<++>
      \}<++>:call bushels#backward_marker(3)
"}}}
" Alias {{{
inoremap <buffer> <leader>ta type<Space>
" }}}
" }}}
" Method {{{
" Declaration {{{
function! GetName() abort
  let save_pos = getpos('.')
  norm ?typewyiw
  call setpos('.', save_pos)
endfunction
inoremap <buffer> <leader>md :call GetName()i
      \func (pb~"_C *") <++>(<++>)<Space><++><Space>{<++>}<++>
      \:call bushels#backward_marker(5)
" }}}
" }}}
" Variable {{{
" Declaration {{{
inoremap <buffer> <leader>vd <++> := <++>:call bushels#backward_marker(2)
" }}}
" Const {{{
inoremap <buffer> <leader>vc const <++> = <++>:call bushels#backward_marker(2)
" }}}
" }}}
