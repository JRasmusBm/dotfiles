" Format {{{
" Blocks {{{
function! FormatJupyterBlock() abort
  norm /`Ndn
  split temp.py
  norm p
  sleep
  norm :call CocAction("format")
  norm ggdG
  norm :q!
  norm P
endfunction

nnoremap   <leader>p :call FormatJupyterBlock()
" }}}
" }}}
