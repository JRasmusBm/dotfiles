Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/promptline.vim'

let g:airline_exclude_previous=0
let g:airline_theme="jellybeans"

let g:promptline_theme = 'airline'
let g:promptline_powerline_symbols = 0
let g:promptline_preset = {
        \'a'    : [ '$HOST' ],
        \'b'    : [ '$(basename `pwd`)' ]}
        " \'c'    : [ promptline#slices#git_status() ]}
