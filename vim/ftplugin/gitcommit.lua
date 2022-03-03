vim.cmd[[
set textwidth=72
setlocal spell spelllang=en_us

execute "source $DOTFILES/vim/snippets/markdown.vim"
]]

vim.keymap.set({ "i" }, "<Leader>c", require("jrasmusbm.mappings").finish_file)
