set splitright

nmap <leader>bd :bp! <BAR> bd #<CR>

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap c<C-j> :bel sp %<cr>
nnoremap c<C-k> :abo sp %<cr>
nnoremap c<C-h> :lefta vsp %<cr>
nnoremap c<C-l> :rightb vsp %<cr>
nnoremap d<C-j> <C-w>j<C-w>c
nnoremap d<C-k> <C-w>k<C-w>c
nnoremap d<C-h> <C-w>h<C-w>c
nnoremap d<C-l> <C-w>l<C-w>c
nnoremap o<C-j> :bel sp %<cr><C-w>j<C-w>c
nnoremap o<C-k> :abo sp %<cr><C-w>k<C-w>c
nnoremap o<C-h> :lefta vsp %<cr><C-w>h<C-w>c
nnoremap o<C-l> :rightb vsp %<cr><C-w>l<C-w>c
