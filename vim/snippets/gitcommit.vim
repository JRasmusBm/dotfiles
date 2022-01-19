" Close {{{
function! CloseCommit() abort
  .+1,$d
  w!
  bd!
endfunction

inoremap <buffer> <leader>c :call CloseCommit()
" }}}
