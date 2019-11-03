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
