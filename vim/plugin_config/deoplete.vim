if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'deoplete-plugins/deoplete-jedi'
Plug 'SevereOverfl0w/deoplete-github'

let g:deoplete#sources = {}
let g:deoplete#sources.gitcommit=['github']

let g:deoplete#enable_at_startup = 1
let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns.gitcommit = '.+'
