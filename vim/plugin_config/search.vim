packadd! popup.nvim
packadd! plenary.nvim
packadd! telescope.nvim
packadd! telescope-fzy-native.nvim
packadd! loupe

let g:LoupeCaseSettingsAlways=1

function! UpdateX()
  let @x = @/[4:-3]
endfunction

nmap <silent> * <Plug>(LoupeStar):call UpdateX()
nmap <silent> # <Plug>(LoupeOctothorpe):call UpdateX()

nnoremap <leader>fs <cmd>lua require('telescope.builtin').git_status()<cr>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>fl <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>f: <cmd>lua require('telescope.builtin').command_history()<cr>
nnoremap <leader>f/ <cmd>lua require('telescope.builtin').search_history()<cr>
nnoremap <leader>fgi <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fgc <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <leader>fgb <cmd>lua require('telescope.builtin').git_branches()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

nnoremap <Leader>ea :Files ~/.vim/after/<CR>
nnoremap <Leader>el :Files ~/.vim/autoload/<CR>
nnoremap <Leader>es :Files ~/.vim/snippets/<CR>
nnoremap <Leader>ep :Files ~/.vim/plugin_config/<CR>
nnoremap <Leader>ef :Files ~/.vim/ftplugin/<CR>
nnoremap <Leader>eo :Files ~/.vim/other_config/<CR>
