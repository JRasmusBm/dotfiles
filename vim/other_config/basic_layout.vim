colorscheme jellybeans
filetype plugin indent on
set relativenumber
set number
set showcmd
set list
set listchars=tab:>-
set signcolumn=yes
set ruler
set laststatus=2
set autoindent
set smartindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set wrap
set textwidth=79
set colorcolumn=+1
set scrolloff=4

autocmd VimResized * :wincmd =

" Set the mouse as a bar in insert mode, as a block in normal mode.
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

nnoremap <silent><Leader>ww :syntax sync fromstart<CR>
