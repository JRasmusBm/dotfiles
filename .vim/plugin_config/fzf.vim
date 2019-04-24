Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

nnoremap <Leader>ff :Files .<CR>
nnoremap <Leader>fgf :GFiles<CR>
nnoremap <Leader>fgs :GFiles?<CR>
nnoremap <Leader>fb :Buffers<CR>
nnoremap <Leader>fl :Lines<CR>
nnoremap <Leader>ft :Tags<CR>
nnoremap <Leader>fm :Marks<CR>
nnoremap <Leader>fw :Windows<CR>
nnoremap <Leader>fhf :History<CR>
nnoremap <Leader>fhc :History:<CR>
nnoremap <Leader>fhs :History/<CR>
nnoremap <Leader>fco :Commits<CR>
nnoremap <Leader>fcm :Commands<CR>
nnoremap <Leader>fm :Maps<CR>
nnoremap <Leader>fh :Helptags<CR>
nnoremap <Leader>fp :Filetypes<CR>
