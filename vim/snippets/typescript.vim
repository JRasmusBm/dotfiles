" Method {{{
" Declaration {{{
inoremap <buffer> <leader>md <++>: (<++>) => <++> = (<++>) => {
      \<++>return <++>; }
      \<++>:call bushels#backward_marker(7)
" }}}
" }}}
" Types {{{
" Interface {{{
inoremap <buffer> <leader>ti interface <++> {<++>}<++>:call bushels#backward_marker(3)
" }}}
" Alias {{{
inoremap <buffer> <leader>ta type <++> = <++>:call bushels#backward_marker(2)
" }}}
" }}}
" Imports {{{
" All {{{
inoremap <buffer> <leader>ia <++>Oimport * as <++> from "<++>";:call bushels#backward_marker(2)
" }}}
" }}}
" }}}
