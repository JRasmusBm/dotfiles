" Bib {{{
" Source {{{
inoremap <buffer> <leader>bs @<++> {
      \<++>,
      \<++>="<++>",<<o
      \}<++>:call bushels#backward_marker(5)
" }}}
" }}}
" Source {{{
" Field {{{
inoremap <buffer> <leader>sf <++>="<++>",:call bushels#backward_marker(2)
" }}}
" }}}
" Add Name {{{
nnoremap <buffer> <leader>an [{/title/"vny]}P]}V2N:s/ *\n */_v/":s/\v(^ *<bar>)/v/":s/ /_/ggu/"ni.pdf"+yi"Nifile_name=/titleN:%!bibclean --no-check-valuesG
" }}}
" Open File {{{
nnoremap <buffer> <leader>of zO[{/file_nameyi":!open ~/2_school/5_y/thesis/papers/"
" }}}
" Open Link {{{
nnoremap <buffer> <leader>ol yi":!open "
" }}}
