" Mypy {{{
" Missing Imports {{{
inoremap <buffer> <leader>mi [mypy-<++>]
  \ignore_missing_imports=True
  \<++>:call bushels#backward_marker(2)
" }}}
" }}}
