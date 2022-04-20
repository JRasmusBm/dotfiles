local mappings = require "jrasmusbm.utils.mappings"

vim.cmd [[
augroup Ruler
  autocmd WinEnter * :silent call jrasmusbm#ruler#source()
  autocmd WinLeave * :silent call jrasmusbm#ruler#off()
augroup END

silent call jrasmusbm#ruler#source()
]]

mappings.nmap(
  "<Leader>sr",
  "<cmd>call jrasmusbm#ruler#toggle()<cr>",
  { noremap = true }
)
