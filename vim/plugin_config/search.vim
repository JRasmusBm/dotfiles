packadd! fzf
packadd! fzf.vim
packadd! loupe
packadd! ack.vim

let g:LoupeCaseSettingsAlways=1
let g:fzf_layout = { "window": {"width": 0.8, "height": 0.8 } }
let $FZF_DEFAULT_OPTS="--reverse"

nnoremap <localleader>ff :Ack<Space>

nnoremap <Leader>ff :GFiles<CR>
nnoremap <Leader>fs :GFiles?<CR>
nnoremap <Leader>fg :Files .<CR>
nnoremap <Leader>fb :Buffers<CR>
nnoremap <Leader>fl :Lines<CR>
nnoremap <Leader>ft :Tags<CR>
nnoremap <Leader>fm :Marks<CR>
nnoremap <Leader>fw :Windows<CR>
nnoremap <Leader>fu :History<CR>
nnoremap <Leader>f: :History:<CR>
nnoremap <Leader>f/ :History/<CR>
nnoremap <Leader>fco :Commits<CR>
nnoremap <Leader>fc :Commands<CR>
nnoremap <Leader>fm :Maps<CR>
nnoremap <Leader>fh :Helptags<CR>
nnoremap <Leader>fe :Filetypes<CR>

nnoremap <Leader>es :Files ~/.vim/snippets/<CR>
nnoremap <Leader>ep :Files ~/.vim/plugin_config/<CR>
nnoremap <Leader>ef :Files ~/.vim/ftplugin/<CR>
nnoremap <Leader>eo :Files ~/.vim/other_config/<CR>
