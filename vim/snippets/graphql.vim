" Query {{{
inoremap <buffer> <leader>qu query <++> {	<++>}
      \:call jrasmusbm#snippets#backward_marker(2)

" }}}
" Type {{{
inoremap <buffer> <leader>qt type <++> {	<++>}
      \:call jrasmusbm#snippets#backward_marker(2)

" }}}
" Mutation {{{
inoremap <buffer> <leader>qm mutation <++> {	<++>}
      \:call jrasmusbm#snippets#backward_marker(2)

" }}}
" Variable {{{
inoremap <buffer> <leader>qv $<++>: <++>!
      \<++>:call jrasmusbm#snippets#backward_marker(3)
" }}}
" Argument {{{
inoremap <buffer> <leader>qa <++>: $<++>
      \<++>:call jrasmusbm#snippets#backward_marker(3)
" }}}
" Field {{{
inoremap <buffer> <leader>qf <++> {	<++>}
      \<++>:call jrasmusbm#snippets#backward_marker(3)
" }}}
" Typename {{{
inoremap <buffer> <leader>qn __typename: "<++>Type",
      \<++>:call jrasmusbm#snippets#backward_marker(2)
" }}}
