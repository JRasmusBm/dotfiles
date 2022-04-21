" Format {{{
" Markdown {{{
function! FormatMarkdownBlock() abort
  norm /`
  split temp.md
  norm p
  sleep
  norm :call CocAction("format")
  norm ggdG
  norm :q!
  norm P
endfunction

nnoremap   <leader>m :call FormatMarkdownBlock()
" }}}
" Python {{{
function! FormatJupyterBlock() abort
  norm /`
  split temp.py
  norm p
  sleep
  norm :call CocAction("format")
  norm ggdG
  norm :q!
  norm P
endfunction

nnoremap <buffer><leader>p :call FormatJupyterBlock()
inoremap <buffer><Leader>cb :VimpyterInsertPythonBlock
" }}}
" }}}