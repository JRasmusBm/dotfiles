vim.cmd [[
packadd fugitive-gitlab.vim
packadd vim-gitgutter
packadd vim-rhubarb
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

vim.api.nvim_create_user_command("G", function(options)
  require("jrasmusbm.utils").ensure_loaded "fugitive-gitlab.vim"
  require("jrasmusbm.utils").ensure_loaded "vim-fugitive"

  vim.cmd("Git " .. options.args)
end, { nargs = "*" })
