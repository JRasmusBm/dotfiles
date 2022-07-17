local mappings = require "jrasmusbm.utils.mappings"

if not require("jrasmusbm.compat").in_termux() then
  mappings.nmap("<C-Y>", '"+y', { noremap = true })
  mappings.nmap("<C-P>", '"+p', { noremap = true })
  mappings.vmap("<C-Y>", '"+y', { noremap = true })
  mappings.vmap("<C-P>", '"+p', { noremap = true })
end

vim.cmd [[
augroup ShowYank
  if exists('##TextYankPost')
    autocmd TextYankPost * lua vim.highlight.on_yank {higroup='IncSearch', timeout=200}
  endif
augroup END
]]
