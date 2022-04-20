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

" Vpm {{{
" File {{{
inoremap <buffer> <leader>vf file_list:
      \- edit <++>
      \highlights:
      \<++>:
      \- ranges:
      \- - <++>
      \- <++>02i o
      \cursorLine: <++>:call bushels#backward_marker(5)
" }}}
" Next File {{{
inoremap <buffer> <leader>vn o<++>:04xo
      \- ranges:
      \- - <++>
      \- <++>02i o
      \cursorLine: <++>:call bushels#backward_marker(4)
" }}}
" Close Next File Sequence (Add file to file list) {{{
inoremap <buffer> <leader>vc mv0wyt:
      \? *highlights:O
      \- edit "'v:call bushels#forward_marker(1)
" }}}
" Highlight {{{
inoremap <buffer> <leader>vh o- ranges:
      \- - <++>
      \- <++>02i o
      \cursorLine: <++>:call bushels#backward_marker(3)
" }}}
" }}}
