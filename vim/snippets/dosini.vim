" Mypy {{{
" Missing Imports {{{
inoremap <buffer> <leader>mi [mypy-<++>]
  \ignore_missing_imports=True
  \<++>:call jrasmusbm#snippets#backward_marker(2)
" }}}
" }}}
