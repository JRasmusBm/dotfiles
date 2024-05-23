local ruler_augroup = vim.api.nvim_create_augroup("ruler", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained" }, {
  group = ruler_augroup,
  pattern = { "*" },
  callback = function()
    require("jrasmusbm.ruler").source()
  end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "FocusLost" }, {
  group = ruler_augroup,
  pattern = { "*" },
  callback = function()
    require("jrasmusbm.ruler").temporarily_disable()
  end,
})

vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.keymap.set({ "n" }, "<Leader>sr", function()
  require("jrasmusbm.ruler").toggle()
end, { noremap = true })

