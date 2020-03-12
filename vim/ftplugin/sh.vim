nnoremap <leader>p :FormatCode<cr>
nnoremap <c-p> :!./%<cr>


source ~/.vim/snippets/bash.vim

function! RunFile() abort
  w
  let path = shellescape(@%, 1)
  exec 'VtrSendCommandToRunner sh ' . path 
endfunction

nnoremap <buffer> <leader>c :call RunFile()
