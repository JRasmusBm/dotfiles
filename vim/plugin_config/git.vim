nnoremap <localleader>fd :VcsJump diff<Space>
nnoremap <localleader>fc :VcsJump merge<Space>
nnoremap <localleader>fg :VcsJump grep<Space>
nnoremap <localleader>ff :Ack<Space>

nnoremap <localleader>cd :Gvdiffsplit! <Space>

let diffopt="filler,context:3,iwhiteall,internal"

let g:fugitive_gitlab_domains = ['https://gitlab.xarepo.com']
