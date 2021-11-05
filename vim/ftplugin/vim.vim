setlocal foldmethod=marker

execute "source $DOTFILES/vim/snippets/vim.vim"

vnoremap <buffer> <localleader>tl y:@"<CR>
nnoremap <buffer> <localleader>tl ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>
nnoremap <buffer> <localleader>tf :so %
nnoremap <buffer> <localleader>ts :so $MYVIMRC
