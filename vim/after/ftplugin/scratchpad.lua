vim.cmd [[
inoremap <buffer> <leader>c :call jrasmusbm#scratchpad#exit()<CR>
nnoremap <buffer> <leader>C :call jrasmusbm#scratchpad#exit()<CR>

setlocal textwidth=0
setlocal wrap

set spell
set spelllang=en_us,
set spelllang+=sv,
set spelllang+=de,
set spelllang+=nl,
]]
