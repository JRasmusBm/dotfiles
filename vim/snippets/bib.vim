
" Bib {{{
" Source {{{
inoremap <buffer> <leader>bs @<++> {
      \<++>,
      \<++>="<++>",<<o
      \}<++>:call BackwardMarker(5)
" }}}
" }}}
" Source {{{
" Field {{{
inoremap <buffer> <leader>sf <++>="<++>",:call BackwardMarker(2)
" }}}
" }}}

nnoremap <buffer> ;an [{/title/"vny]}P]}V2N:s/ *\n */_v/":s/\v(^ *<bar>)/v/":s/ /_/ggu/"ni.pdf"+yi"Nifile_name=/titleN:%! bibcleanG
nnoremap <buffer> ;of zO[{/file_nameyi":!br ~/2_school/5_y/thesis/papers/"
