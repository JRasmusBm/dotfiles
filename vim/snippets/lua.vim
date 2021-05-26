" Function{{{
" Definition {{{
inoremap <buffer> <leader>fd function <++>(<++>)
      \<++>
      \end:call bushels#backward_marker(3)
"}}}
"}}}

" Lua {{{
" File {{{
inoremap <buffer> <leader>lf local M = {}
      \<++>
      \return M:call bushels#backward_marker(1)
" }}}
" }}}

" Log {{{
" Breakpoint {{{
inoremap <buffer> <leader>lb print(
      \vim.inspect({
      \file = "%",
      \line = =line("."),
      \<++>,
      \})
      \):call bushels#backward_marker(1)
" }}}
" }}}

" Control Statement {{{
" If {{{
inoremap <buffer> <leader>ci if <++> then
      \<++>
      \end:call bushels#backward_marker(2)
" }}}
" }}}
