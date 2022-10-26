local mappings = require "jrasmusbm.utils.mappings"

vim.cmd [[
packadd loupe
packadd vcs-jump
]]

vim.g.LoupeCaseSettingsAlways = 1

vim.keymap.set({ "n" }, "gs", ':%s/<c-r>=expand("<cword>")<cr>/')

vim.keymap.set(
  { "n" },
  "*",
  "<Plug>(LoupeStar)<cmd>lua require('jrasmusbm.search').set_search_as_x()<CR>",
  { silent = true }
)
vim.keymap.set(
  { "n" },
  "#",
  "<Plug>(LoupeOctothorpe)<cmd>lua require('jrasmusbm.search').set_search_as_x()<CR>",
  { silent = true }
)

vim.keymap.set({ "n" }, "<Leader> fc", "<cmd>Cheat<CR>", { noremap = true })

vim.keymap.set({ "n" }, "<localleader>fd", ":VcsJump diff<Space>")
vim.keymap.set({ "n" }, "<localleader>fg", ":VcsJump grep<Space>")
vim.keymap.set({ "n" }, "<localleader>fm", ":VcsJump merge<Space>")

vim.keymap.set({ "n" }, "<C-O>", "<C-O>zz", { noremap = true })
vim.keymap.set({ "n" }, "<C-I>", "<C-I>zz", { noremap = true })

vim.keymap.set({ "n" }, "n", "nzzzv", { noremap = true })
vim.keymap.set({ "n" }, "N", "Nzzzv", { noremap = true })
mappings.vmap("n", "nzzzv", { noremap = true })
mappings.vmap("N", "Nzzzv", { noremap = true })
