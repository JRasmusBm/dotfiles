vim.schedule(function()
  vim.keymap.set(
    { "n" },
    "<tab>",
    ":call search('|.\\{\\-\\}|')<cr>:noh<cr>2l",
    { buffer = 0 }
  )
  vim.keymap.set(
    { "n" },
    "<s-tab>",
    "F|:call search('|.\\{\\-\\}|', 'b')<cr>:noh<cr>2l",
    { buffer = 0 }
  )
  vim.keymap.set({ "n" }, "<cr>", "<c-]>", { buffer = true })
  vim.keymap.set({ "n" }, "<bs>", "<c-T>", { buffer = true })
  vim.keymap.set({ "n" }, "q", ":q<CR>", { buffer = true })
  vim.opt_local.number = false
  vim.cmd.only()
end)
