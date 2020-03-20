let g:airline_disable_statusline = 1
let g:airline_powerline_fonts = 1
let g:airline_theme="jellybeans"

let g:airline_focuslost_inactive = 1


let g:airline_extensions = ["coc"]

let g:airline#extensions#default#layout = [
  \ ["a", "c"],
  \ ["x", "z", "error", "warning"],
  \]

let g:airline_section_z = '%l, %c'
let g:airline_skip_empty_sections = 1
