let b:ale_fixers = ['black']

match BadWhitespace /\s\+$/

py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

nnoremap <C-p> :w<cr> :exec '!python' shellescape(@%, 1)<cr>

source ~/.vim/snippets/python.vim
