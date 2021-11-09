vim.cmd [[
packadd! nvim-compe

set completeopt=menuone,noselect

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <C-y> compe#confirm('<CR>')
inoremap <silent><expr> <C-e> compe#close('<C-e>')
inoremap <silent><expr> <C-u> compe#scroll({ 'delta': -4 })
inoremap <silent><expr> <C-d> compe#scroll({ 'delta': +4 })
]]
