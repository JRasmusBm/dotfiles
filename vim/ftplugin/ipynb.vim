packadd! vimpyter

autocmd Filetype ipynb nmap <silent><Leader>jb <cmd>VimpyterInsertPythonBlock<CR>
autocmd Filetype ipynb nmap <silent><Leader>js <cmd>VimpyterStartJupyter<CR>
autocmd Filetype ipynb nmap <silent><Leader>jn <cmd>VimpyterStartNteract<CR>

execute "source $DOTFILES/vim/snippets/python.vim"
execute "source $DOTFILES/vim/snippets/markdown.vim"
execute "source $DOTFILES/vim/snippets/ipynb.vim"
