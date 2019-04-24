if has('nvim')
  Plug 'Quramy/tsuquyomi'
  Plug 'mhartington/nvim-typescript', {'do': 'npm install && npm run build'}
  Plug 'HerringtonDarkholme/yats.vim'
else
  Plug 'leafgarland/typescript-vim'
endif

Plug 'heavenshell/vim-tslint-config'
Plug 'ianks/vim-tsx'
