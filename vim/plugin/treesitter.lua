vim.cmd [[
packadd! nvim-treesitter
packadd! nvim-treesitter-textobjects
packadd! nvim-treesitter-playground
packadd! indent-blankline.nvim
]]

vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_char = "│"

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
