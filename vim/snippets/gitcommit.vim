" Close {{{
function! CloseCommit() abort
  norm jd/#
  exec wq
endfunction

inoremap <buffer> <leader>c :call CloseCommit()
" }}}
