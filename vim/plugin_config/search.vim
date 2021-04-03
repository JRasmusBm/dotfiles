packadd! fzf
packadd! fzf.vim
packadd! loupe
packadd! vim-ripgrep

let g:LoupeCaseSettingsAlways=1
let g:fzf_layout = { "window": {"width": 0.8, "height": 0.8 } }
let $FZF_DEFAULT_OPTS="--reverse --preview 'bat --style=numbers --color=always --line-range :500 {}'"

nnoremap <localleader>ff :Rg<Space>

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
nnoremap <Leader>fc :Commits<CR>
nnoremap <Leader>f:r :Commands<CR>
nnoremap <Leader>fm :Maps<CR>
nnoremap <Leader>fh :Helptags<CR>
nnoremap <Leader>fe :Filetypes<CR>


nnoremap <Leader>ea :Files ~/.vim/after/<CR>
nnoremap <Leader>el :Files ~/.vim/autoload/<CR>
nnoremap <Leader>es :Files ~/.vim/snippets/<CR>
nnoremap <Leader>ep :Files ~/.vim/plugin_config/<CR>
nnoremap <Leader>ef :Files ~/.vim/ftplugin/<CR>
nnoremap <Leader>eo :Files ~/.vim/other_config/<CR>
