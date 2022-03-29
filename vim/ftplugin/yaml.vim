execute "source $DOTFILES/vim/snippets/yaml.vim"

function! RunFile() abort
  w
  let path = shellescape(@%, 1)
  exec 'VtrSendCommandToRunner docker compose -f ' . path . ' down --remove-orphans'
  exec 'VtrSendCommandToRunner docker compose -f ' . path . ' up --remove-orphans --build'
endfunction

nnoremap <buffer> <leader>c :call RunFile()
