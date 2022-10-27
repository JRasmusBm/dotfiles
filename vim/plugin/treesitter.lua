vim.cmd [[
packadd nvim-treesitter
packadd nvim-treesitter-textobjects
packadd indent-blankline.nvim
]]

vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_char = "│"

vim.api.nvim_create_user_command("TSP", function()
  require("jrasmusbm.utils").ensure_setup("nvim-treesitter-playground")

 vim.cmd ("TSPlaygroundToggle")

  
end, { nargs = 0})
