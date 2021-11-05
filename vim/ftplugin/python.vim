match BadWhitespace /\s\+$/

function! RunFile() abort
  w
  let path = shellescape(@%, 1)
  let module_path = join(split(split(path, '\.')[0], '/') , '.') . "'"
  echo module_path
  exec 'VtrSendCommandToRunner python -m ' . module_path
endfunction

nnoremap <buffer> <leader>c :call RunFile()

execute "source $DOTFILES/vim/snippets/python.vim"
