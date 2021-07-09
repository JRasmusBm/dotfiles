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

command! GFiles lua require('jrasmusbm.telescope.git_files').git_files()
nnoremap <leader>ff <cmd>GFiles<cr>
nnoremap <leader>fl <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>f: <cmd>lua require('telescope.builtin').command_history()<cr>
nnoremap <leader>f/ <cmd>lua require('telescope.builtin').search_history()<cr>
nnoremap <leader>fa <cmd>lua require('jrasmusbm.telescope.find_files').find_files({})<cr>
nnoremap <leader>fgc <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <leader>fgb <cmd>lua require('telescope.builtin').git_branches()<cr>
nnoremap <leader>fgs <cmd>lua require('telescope.builtin').git_status()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

nnoremap <leader>ea <cmd>lua require('jrasmusbm.telescope.find_files').find_files({
  \   prompt_title = "All Files",
  \   cwd = "~/.vim/after/"
  \ })
nnoremap <leader>eu <cmd>lua require('jrasmusbm.telescope.find_files').find_files({
  \   prompt_title = "Autoload Files",
  \   cwd = "~/.vim/autoload/"
  \ })
nnoremap <leader>el <cmd>lua require('jrasmusbm.telescope.find_files').find_files({
  \   prompt_title = "Lua Files",
  \   cwd = "~/.vim/lua/"
  \ })
nnoremap <leader>es <cmd>lua require('jrasmusbm.telescope.find_files').find_files({
  \   prompt_title = "Snippet Files",
  \   cwd = "~/.vim/snippets/"
  \ })
nnoremap <leader>ep <cmd>lua require('jrasmusbm.telescope.find_files').find_files({
  \   prompt_title = "Plugin Config Files",
  \   cwd = "~/.vim/plugin_config/"
  \ })
nnoremap <leader>eb <cmd>lua require('jrasmusbm.telescope.find_files').find_files({
  \   prompt_title = "Filetype Config Files",
  \   cwd = vim.fn.getenv("DOTFILES") .. "/bin"
  \ })
nnoremap <leader>ei <cmd>lua require('jrasmusbm.telescope.find_files').find_files({
  \   prompt_title = "Filetype Config Files",
  \   cwd = vim.fn.getenv("DOTFILES") .. "/install_dependencies"
  \ })
nnoremap <leader>ef <cmd>lua require('jrasmusbm.telescope.find_files').find_files({
  \   prompt_title = "Filetype Config Files",
  \   cwd = "~/.vim/ftplugin/"
  \ })
nnoremap <leader>eo <cmd>lua require('jrasmusbm.telescope.find_files').find_files({
  \   prompt_title = "Other Config Files",
  \   cwd = "~/.vim/other_config/"
  \ })
