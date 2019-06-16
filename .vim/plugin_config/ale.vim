let g:ale_completion_enabled = 1

let g:ale_close_preview_on_insert = 1
let g:ale_cursor_detail = 1

" Python
let g:ale_python_auto_pipenv = 1

let g:airline#extensions#ale#enabled = 1

let g:ale_linters = {
  \ 'rust': ['rls'],
  \ 'haskell': ['hlint', 'hdevtools', 'hfmt', 'stack-build'],
  \ 'python': ['pyls', 'pylint', 'mypy'],
  \}

let g:ale_python_pyls_config = {
  \   'pyls': {
  \     'plugins': {
  \       'pycodestyle': {
  \         'enabled': v:false
  \       }
  \     }
  \   },
  \ }

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\ }
let g:ale_python_black_options="--line-length 80"

Plug 'w0rp/ale'

nnoremap <leader>a? :ALEDocumentation
nnoremap <leader>ah :ALEHover
nnoremap <leader>al :ALELint
nnoremap <leader>af :ALESymbolSearch
nnoremap <leader>ad :ALEGoToDefinition
nnoremap <leader>at :ALEGoToTypeDefinition


nnoremap <leader>p :ALEFix

nnoremap ]v :ALENext
nnoremap [v :ALEPrevious

nnoremap <leader>p :ALEFix
