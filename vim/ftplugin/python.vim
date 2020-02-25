let b:ale_fixers = ['black', 'isort']

match BadWhitespace /\s\+$/

py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

function! RunFile() abort
  w
  let path = shellescape(@%, 1)
  let module_path = join(split(split(path, '\.')[0], '/') , '.') . "'"
  echo module_path
  exec 'VtrSendCommandToRunner python -m ' . module_path
endfunction

nnoremap <buffer> <leader>c :call RunFile()

source ~/.vim/snippets/python.vim
