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
  \:call bushels#backward_marker(4)
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
" Section {{{
inoremap <buffer> <leader>fs <++>:
      \<++>:call bushels#backward_marker(2)
" }}}
" List {{{
inoremap <buffer> <leader>fl <++>:
      \- <++>
      \<++><<<<:call bushels#backward_marker(3)
" }}}
" }}}

" List {{{
" Node {{{
inoremap <buffer> <leader>ln yyp^wC
" }}}
" }}}
