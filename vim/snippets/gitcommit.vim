" Close {{{
function! CloseCommit() abort
  norm +0d/#
  wq
endfunction

inoremap <buffer> <leader>c :call CloseCommit()
" }}}
