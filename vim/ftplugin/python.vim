let b:ale_fixers = ['black', 'isort']

match BadWhitespace /\s\+$/

function! RunFile() abort
  w
  let path = shellescape(@%, 1)
  let module_path = join(split(split(path, '\.')[0], '/') , '.') . "'"
  echo module_path
  exec 'VtrSendCommandToRunner python -m ' . module_path
endfunction

nnoremap <buffer> <leader>c :call RunFile()

source ~/.vim/snippets/python.vim

call jrasmusbm#coc#setup_maps()
