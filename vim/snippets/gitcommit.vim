" Close {{{
function! CloseCommit() abort
  norm /#dG
  w!
  bd!
endfunction

inoremap <buffer> <leader>c :call CloseCommit()
" }}}
