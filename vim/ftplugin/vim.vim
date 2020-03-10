setlocal foldmethod=marker

source ~/.vim/snippets/vim.vim
vnoremap <buffer> <leader>c y:@"<CR>
nnoremap <buffer> <leader>c ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>

