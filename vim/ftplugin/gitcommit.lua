vim.cmd [[
execute "source $DOTFILES/vim/snippets/markdown.vim"
]]

vim.opt.textwidth = 72

vim.opt_local.spell = true
vim.opt_local.spelllang = { "en_us" }

vim.keymap.set({ "i" }, "<Leader>c", require("jrasmusbm.mappings").finish_file)
