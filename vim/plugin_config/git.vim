packadd! fugitive-gitlab.vim
packadd! vim-gitgutter
packadd! vim-fugitive
packadd! vcs-jump

nnoremap <localleader>fd :VcsJump diff<Space>
nnoremap <localleader>fc :VcsJump merge<Space>
nnoremap <localleader>fg :VcsJump grep<Space>

let g:current_diff_reference = ""

command! -nargs=+ -complete=file DStart call jrasmusbm#git#changes(<q-args>)
command! DNext call jrasmusbm#git#next_changes()
command! DCurrent call jrasmusbm#git#open_diff()
command! DPrevious call jrasmusbm#git#previous_changes()

nnoremap <localleader>cd :Gvdiffsplit! <Space>

set diffopt=""
set diffopt+=filler
set diffopt+=context:3
set diffopt+=iwhiteall
set diffopt+=internal
set diffopt+=hiddenoff

let g:fugitive_gitlab_domains = ['https://gitlab.xarepo.com']
