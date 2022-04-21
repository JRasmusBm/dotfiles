vim.cmd [[
packadd! fugitive-gitlab.vim
packadd! vim-gitgutter
packadd! vim-rhubarb
packadd vim-fugitive
packadd! nvim-web-devicons
packadd! diffview.nvim

command! -nargs=? L silent call jrasmusbm#git#open_tree(<f-args>)

command! Gpa call jrasmusbm#git#push_all()
]]

vim.g.diffopt = require("jrasmusbm.utils.options").list {
  "filler",
  "context:3",
  "iwhiteall",
  "internal",
  "hiddenoff",
}

vim.g.fugitive_gitlab_domains = {}
