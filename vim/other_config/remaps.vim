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

nnoremap <expr> j (v:count > 3 ? "m'" . v:count : "") . 'j'
nnoremap <expr> k (v:count > 3 ? "m'" . v:count : "") . 'k'

nmap == :call jrasmusbm#format#default()
