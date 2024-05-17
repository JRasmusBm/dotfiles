vim.cmd [[
command! -nargs=? L silent call jrasmusbm#git#open_tree(<f-args>)
]]

vim.api.nvim_create_user_command("Gpa", function()
  vim.cmd.wa { bang = true }
  vim.cmd.G { "wip" }
  vim.cmd.G { "rbof" }
  vim.cmd.G { "push --no-verify" }
end, { nargs = 0 })

vim.g.diffopt = require("jrasmusbm.utils.options").list {
  "filler",
  "context:3",
  "iwhiteall",
  "internal",
  "hiddenoff",
}
vim.g.fugitive_git_executable = "g"

vim.g.fugitive_gitlab_domains = {}

vim.keymap.set({ "n", "x" }, "<leader>h", function()
  require("jrasmusbm.git").open_github_link()
end)
