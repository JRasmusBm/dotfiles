Plug 'w0rp/ale'

let g:airline#extensions#ale#enabled = 1

let g:ale_linters = {
  \ 'rust': ['rls'], 
  \ 'haskell': ['hlint', 'hdevtools', 'hfmt', 'stack-build'],
  \}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\ }

nnoremap <leader>p :ALEFix
nnoremap <leader>cp :ALELint

nnoremap ]v :ALENext
nnoremap [v :ALEPrevious

nnoremap <leader>p :ALEFix

nnoremap <leader>? :call ale#cursor#ShowCursorDetail()
