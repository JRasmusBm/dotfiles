" Bib {{{
" Source {{{
inoremap <buffer> <leader>bs @<++> {
      \<++>,
      \<++>="<++>",<<o
      \}
" }}}
" }}}
" Source {{{
" Field {{{
inoremap <buffer> <leader>sf <++>="<++>",:call bushels#backward_marker(2)
" }}}
" }}}
" Add Name {{{
nnoremap <buffer> <leader>an [{/title
" }}}
" Open File {{{
nnoremap <buffer> <leader>of zO[{/file_name
" }}}
" Open Link {{{
nnoremap <buffer> <leader>ol yi":!open "
" }}}