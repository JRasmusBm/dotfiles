require("jrasmusbm.utils").ensure_setup "vim-gitgutter"
require("jrasmusbm.utils").ensure_setup "nvim-web-devicons"

vim.cmd [[
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

local bang_marker = function(options)
  if options.bang then
    return "!"
  end
  return ""
end

local enriched_command = function(options)
  local root_cmd = "Git"

  if options.fargs[1] == "browse" or options.fargs[1] == "br" then
    table.remove(options.fargs, 1)
    root_cmd = "GBrowse"
  elseif options.fargs[1] == "bl" then
    options.fargs[1] = "blame"
  end

  return root_cmd
    .. bang_marker(options)
    .. " "
    .. table.concat(options.fargs, " ")
end

vim.api.nvim_create_user_command("G", function(options)
  require("jrasmusbm.utils").ensure_setup "vim-rhubarb"
  require("jrasmusbm.utils").ensure_setup "fugitive-gitlab.vim"
  require("jrasmusbm.utils").ensure_setup "vim-fugitive"

  vim.cmd(enriched_command(options))
end, { nargs = "*", bang = true })

vim.keymap.set({ "n", "x" }, "<leader>h", function()
  require("jrasmusbm.git").open_github_link()
end)
