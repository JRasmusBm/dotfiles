" Query {{{
inoremap <buffer> <leader>qu query <++> {	<++>}
      \:call BackwardMarker(2)

" }}}
" Mutation {{{
inoremap <buffer> <leader>qm mutation <++> {	<++>}
      \:call BackwardMarker(2)

" }}}
" Variable {{{
inoremap <buffer> <leader>qv $<++>: <++>!
      \<++>:call BackwardMarker(3)
" }}}
" Argument {{{
inoremap <buffer> <leader>qa <++>: $<++>
      \<++>:call BackwardMarker(3)
" }}}
" Field {{{
inoremap <buffer> <leader>qf <++> {	<++>}
      \<++>:call BackwardMarker(3)
" }}}
" Typename {{{
inoremap <buffer> <leader>qn __typename: "<++>Type",
      \<++>:call BackwardMarker(2)
" }}}
