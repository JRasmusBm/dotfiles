vim.cmd [[
augroup Ruler
  autocmd WinEnter * :silent call jrasmusbm#ruler#source()
  autocmd WinLeave * :silent call jrasmusbm#ruler#off()
augroup END

silent call jrasmusbm#ruler#source()
]]

vim.keymap.set({ "n" },
  "<Leader>sr",
  "<cmd>call jrasmusbm#ruler#toggle()<cr>",
  { noremap = true }
)
