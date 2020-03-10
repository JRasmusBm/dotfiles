" Compose {{{
" File {{{
inoremap <buffer> <leader>cf version: "3"
  \services:
  \<++>:
  \container_name: <++>
  \build: .
  \image: <++>
  \command:
  \  sh -c "<++>"
  \:call BackwardMarker(4)
" }}}
" }}}

" Section {{{
" Network {{{
inoremap <buffer> <leader>sn :call append('$', "networks:")
      \:call append('$', "  :")
      \:call cursor('$', 3)
      \i
" }}}
" }}}

" Field {{{
" List {{{
inoremap <buffer> <leader>fl <++>:
      \- <++>
      \<++><<<<:call BackwardMarker(3)
" }}}
" }}}

" List {{{
" Node {{{
inoremap <buffer> <leader>ln yyp^wC
" }}}
" }}}
