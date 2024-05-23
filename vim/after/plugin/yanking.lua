vim.keymap.set({ "n" },"<C-Y>", '"+y', { noremap = true })
vim.keymap.set({ "n" },"<C-P>", '"+p', { noremap = true })
vim.keymap.set({ "v" },"<C-Y>", '"+y', { noremap = true })
vim.keymap.set({ "v" },"<C-P>", '"+p', { noremap = true })

vim.cmd [[
augroup ShowYank
if exists('##TextYankPost')
  autocmd TextYankPost * lua vim.highlight.on_yank {higroup='IncSearch', timeout=200}
  endif
  augroup END
  ]]
