Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'wincent/vcs-jump'

nnoremap <localleader>fd :VcsJump diff<Space>
nnoremap <localleader>fc :VcsJump merge<Space>
nnoremap <localleader>fg :VcsJump grep<Space>
nnoremap <localleader>ff :Ack<Space>
