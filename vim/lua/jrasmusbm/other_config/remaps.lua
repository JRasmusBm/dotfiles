vim.cmd [[
inoremap <C-c> <Esc>
nmap Q <nop>
nmap gQ qqVipJ2jq2{w0

inoremap <leader>D =strftime("%Y-%m-%d")
inoremap <leader>T =strftime("%H:%M")

nnoremap go o<Esc>S
nnoremap gO O<Esc>S

nnoremap <silent> <leader>qo :copen
nnoremap <silent> <leader>qc :cclose

nnoremap <silent> <leader>lo :lopen
nnoremap <silent> <leader>lc :lclose

xmap <leader>h <cmd>call jrasmusbm#open#github()<CR>

nmap == :call jrasmusbm#format#default()
]]
