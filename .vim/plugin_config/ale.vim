Plug 'w0rp/ale'

let g:airline#extensions#ale#enabled = 1
let g:ale_linters = {
  \ 'rust': ['rls'], 
  \ 'haskell': ['hlint', 'hdevtools', 'hfmt', 'stack-build'],
  \}

