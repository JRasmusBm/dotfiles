local update_filetypes = function()
  for target, sources in pairs(require "jrasmusbm.filetypes") do
    if target ~= "tsx" and target ~= "jsx" then
      vim.treesitter.language.register(target, sources)
    end
  end
  vim.treesitter.language.register("tsx", require("jrasmusbm.filetypes").tsx)
  vim.treesitter.language.register("jsx", require("jrasmusbm.filetypes").jsx)
end

local M = {}

M.ensure_setup = function()
  if not require("jrasmusbm.utils").ensure_setup "nvim-treesitter" then
    return
  end
  update_filetypes()

  require("jrasmusbm.utils").ensure_setup "nvim-treesitter-textobjects"
  require("jrasmusbm.utils").ensure_setup "indent-blankline.nvim"

  vim.g.indent_blankline_use_treesitter = true
  vim.g.indent_blankline_show_current_context = true
  vim.g.indent_blankline_char = "│"

  require("nvim-treesitter.configs").setup {
    highlight = { enable = true, disable = { "markdown", "help" } },
    query_linter = require("jrasmusbm.treesitter.query_linter").query_linter,
    textobjects = {
      select = require("jrasmusbm.treesitter.select").select,
      swap = require("jrasmusbm.treesitter.swap").swap,
      move = require("jrasmusbm.treesitter.move").move,
    },
  }

  require("jrasmusbm.treesitter.context").ensure_setup()
end

return M
