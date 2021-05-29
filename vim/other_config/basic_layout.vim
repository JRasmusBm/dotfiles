set relativenumber
set number
set showcmd
set noemoji
set list
set listchars=tab:>-
set signcolumn=auto
set ruler
set laststatus=2
set cmdheight=2
set wrap
set textwidth=79
set colorcolumn=+1
set scrolloff=4

autocmd VimResized * :wincmd =

" Set the mouse as a bar in insert mode, as a block in normal mode.
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

nnoremap <silent><Leader>ww :syntax sync fromstart<CR>

highlight! Normal ctermbg=NONE guibg=NONE
highlight! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
