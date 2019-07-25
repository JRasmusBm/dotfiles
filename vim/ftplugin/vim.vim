setlocal foldmethod=marker

source ~/.vim/snippets/vim.vim
vnoremap <C-P> y:@"<CR>
nnoremap <C-P> ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>

