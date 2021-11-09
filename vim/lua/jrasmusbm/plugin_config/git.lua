packadd! fugitive-gitlab.vim
packadd! vim-gitgutter
packadd! vim-rhubarb
packadd! vim-fugitive
packadd! nvim-web-devicons
packadd! diffview.nvim

set diffopt=""
set diffopt+=filler
set diffopt+=context:3
set diffopt+=iwhiteall
set diffopt+=internal
set diffopt+=hiddenoff

command! L silent call jrasmusbm#git#open_tree()

let g:fugitive_gitlab_domains = []
