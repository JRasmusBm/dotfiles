packadd! vim-emoji
packadd! nvim-compe

set completefunc=emoji#complete
set completeopt=menuone,noselect

command! Emojify keeppatterns %s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <C-y> compe#confirm('<CR>')
inoremap <silent><expr> <C-e> compe#close('<C-e>')
inoremap <silent><expr> <C-u> compe#scroll({ 'delta': -4 })
inoremap <silent><expr> <C-d> compe#scroll({ 'delta': +4 })
