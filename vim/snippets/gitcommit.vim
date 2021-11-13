" Close {{{
function! CloseCommit() abort
  norm +0d/#
  w!
  bd!
endfunction

inoremap <buffer> <leader>c :call CloseCommit()
" }}}
