let g:airline_exclude_previous=0
let g:airline_powerline_fonts = 1
let g:airline_theme="jellybeans"

let g:promptline_theme = 'airline'
let g:promptline_powerline_symbols = 1
let g:promptline_preset = {
        \'a'    : [ '$HOST' ],
        \'b'    : [ '$(basename `pwd`)' ]}
        " \'c'    : [ promptline#slices#git_status() ]}
