Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/promptline.vim'
Plug 'edkolev/tmuxline.vim'

let g:airline#extensions#tabline#enabled = 1
let g:airline_exclude_previous=0

let airline#extensions#tmuxline#snapshot_file = '~/.tmux-status.conf'
