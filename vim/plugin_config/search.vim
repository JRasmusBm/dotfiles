packadd! popup.nvim
packadd! plenary.nvim
packadd! telescope.nvim
packadd! telescope-fzy-native.nvim
packadd! loupe
packadd! vcs-jump

let g:LoupeCaseSettingsAlways=1

function! UpdateX()
  let @x = @/[4:-3]
endfunction

nmap <silent> * <Plug>(LoupeStar):call UpdateX()
nmap <silent> # <Plug>(LoupeOctothorpe):call UpdateX()

command! GFiles lua require('jrasmusbm.telescope.git_files').git_files()

" Search in Vim {{{
nnoremap <leader>ff <cmd>lua require('jrasmusbm.telescope.find_files').find_files({})<cr>
nnoremap <leader>fq <cmd>lua require('telescope.builtin').quickfix({})<cr>
nnoremap <leader>fl <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>f: <cmd>lua require('telescope.builtin').command_history()<cr>
nnoremap <leader>f/ <cmd>lua require('telescope.builtin').search_history()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
command! Reg Telescope registers
"}}}

" Search in Git {{{
nnoremap <localleader>ff <cmd>lua require('jrasmusbm.telescope.git_files').git_files({
      \   show_untracked = true
      \ })<cr>
nnoremap <localleader>fd :VcsJump diff<Space>
nnoremap <localleader>fg :VcsJump grep<Space>
nnoremap <localleader>fm :VcsJump merge<Space>
nnoremap <localleader>fc <cmd>lua require('jrasmusbm.telescope.git_commits').git_commits()<cr>
nnoremap <localleader>fi <cmd>lua require('jrasmusbm.telescope.git_issues').git_issues()<cr>
nnoremap <localleader>fp <cmd>lua require('jrasmusbm.telescope.git_pull_requests').git_pull_requests()<cr>
nnoremap <localleader>fb <cmd>lua require('jrasmusbm.telescope.git_branches').git_branches()<cr>
nnoremap <localleader>fs <cmd>lua require('telescope.builtin').git_status()<cr>
"}}}

" Search in Configuration {{{
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
  \   prompt_title = "Install Dependencies",
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
"}}}
nnoremap <leader>et <cmd>lua require('jrasmusbm.telescope.find_files').find_files({
  \   prompt_title = "Treesitter Queries",
  \   cwd = "~/.vim/queries/"
  \ })
"}}}
