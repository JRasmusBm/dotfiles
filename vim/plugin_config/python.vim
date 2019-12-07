Plug 'davidhalter/jedi-vim'
Plug 'szymonmaszke/vimpyter'

autocmd Filetype ipynb nmap <silent><Leader>jb :VimpyterInsertPythonBlock<CR>
autocmd Filetype ipynb nmap <silent><Leader>js :VimpyterStartJupyter<CR>
autocmd Filetype ipynb nmap <silent><Leader>jn :VimpyterStartNteract<CR>

let g:jedi#goto_command = "<leader>ad"
let g:jedi#goto_assignments_command = "<leader>aa"
let g:jedi#documentation_command = "<leader>ah"
let g:jedi#rename_command = "<leader>ar"
let g:jedi#usages_command = "<leader>an"
