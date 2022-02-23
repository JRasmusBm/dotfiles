vim.keymap.set({"n"}, "D", function()
  vim.cmd [[
  DiffViewOpen
  ]]

end, {buffer = 0})

vim.keymap.set({"n"}, "L", vim.fn["jrasmusbm#git#open_tree"], {silent = true})
vim.keymap.set({"n"}, "q", "q", {noremap = true})
