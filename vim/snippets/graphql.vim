" Query {{{
inoremap <buffer> <leader>qu query <++> {	<++>}
      \:call bushels#backward_marker(2)

" }}}
" Type {{{
inoremap <buffer> <leader>qt type <++> {	<++>}
      \:call bushels#backward_marker(2)

" }}}
" Mutation {{{
inoremap <buffer> <leader>qm mutation <++> {	<++>}
      \:call bushels#backward_marker(2)

" }}}
" Variable {{{
inoremap <buffer> <leader>qv $<++>: <++>!
      \<++>:call bushels#backward_marker(3)
" }}}
" Argument {{{
inoremap <buffer> <leader>qa <++>: $<++>
      \<++>:call bushels#backward_marker(3)
" }}}
" Field {{{
inoremap <buffer> <leader>qf <++> {	<++>}
      \<++>:call bushels#backward_marker(3)
" }}}
" Typename {{{
inoremap <buffer> <leader>qn __typename: "<++>Type",
      \<++>:call bushels#backward_marker(2)
" }}}
