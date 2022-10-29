vim.cmd [[
packadd loupe
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

vim.keymap.set({ "n" }, "<localleader>fd",function ()
  require("jrasmusbm.utils").ensure_setup("vcs-jump")
  require("jrasmusbm.utils.mappings").feedkeys ":VcsJump diff "
end

)
vim.keymap.set({ "n" }, "<localleader>fg",function ()
  require("jrasmusbm.utils").ensure_setup("vcs-jump")
  require("jrasmusbm.utils.mappings").feedkeys ":VcsJump grep "
end

)
vim.keymap.set({ "n" }, "<localleader>fm",function ()
  require("jrasmusbm.utils").ensure_setup("vcs-jump")
  require("jrasmusbm.utils.mappings").feedkeys ":VcsJump merge "
end

)

vim.keymap.set({ "n" }, "<C-O>", "<C-O>zz", { noremap = true })
vim.keymap.set({ "n" }, "<C-I>", "<C-I>zz", { noremap = true })

vim.keymap.set({ "n" }, "n", "nzzzv", { noremap = true })
vim.keymap.set({ "n" }, "N", "Nzzzv", { noremap = true })
vim.keymap.set({ "v" }, "n", "nzzzv", { noremap = true })
vim.keymap.set({ "v" }, "N", "Nzzzv", { noremap = true })
