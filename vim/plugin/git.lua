vim.cmd [[
packadd fugitive-gitlab.vim
packadd vim-gitgutter
packadd vim-rhubarb
packadd vim-fugitive
packadd nvim-web-devicons

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
vim.g.fugitive_git_executable = "g"

vim.g.fugitive_gitlab_domains = {}

vim.api.nvim_create_user_command("DO", function(_, fargs)
  require("jrasmusbm.diffview").ensure_setup()

  vim.cmd { cmd = "DiffviewOpen", args = fargs }
end, { nargs = "*" })

vim.api.nvim_create_user_command("DFH", function(_, fargs)
  require("jrasmusbm.diffview").ensure_setup()

  vim.cmd { cmd = "DiffviewFileHistory", args = fargs }
end, { nargs = "*" })
