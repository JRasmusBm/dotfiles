set runtimepath+=~/.vim,~/.vim/after
set packpath+=~/.vim
let g:python3_host_prog="$HOME".'/.virtualenvs/neovim3/bin/python'

if has('nvim')
  lua <<
    CorpusDirectories = {
      ['~/projects/notes'] = {
        autocommit = false,
        autoreference = 0,
        autotitle = 0,
        base = './',
        transform = 'local',
      },
  }
.
endif

source ~/.vimrc
