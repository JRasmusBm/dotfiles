packadd! fugitive-gitlab.vim
packadd! vim-gitgutter
packadd! vim-fugitive
packadd! vcs-jump
packadd! nvim-web-devicons
packadd! diffview.nvim

nnoremap <localleader>fd :VcsJump diff<Space>
nnoremap <localleader>fc :VcsJump merge<Space>
nnoremap <localleader>fg :VcsJump grep<Space>

set diffopt=""
set diffopt+=filler
set diffopt+=context:3
set diffopt+=iwhiteall
set diffopt+=internal
set diffopt+=hiddenoff

let g:fugitive_gitlab_domains = ['https://gitlab.xarepo.com']
