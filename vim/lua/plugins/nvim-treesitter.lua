return {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    for target, sources in pairs(require "jrasmusbm.filetypes") do
      if target ~= "tsx" and target ~= "jsx" then
        vim.treesitter.language.register(target, sources)
      end
    end
    vim.treesitter.language.register("tsx", require("jrasmusbm.filetypes").tsx)
    vim.treesitter.language.register("jsx", require("jrasmusbm.filetypes").jsx)

    require("nvim-treesitter.configs").setup {
      highlight = { enable = true, disable = { "markdown", "help" } },
      query_linter = require("jrasmusbm.treesitter.query_linter").query_linter,
      textobjects = {
        select = require("jrasmusbm.treesitter.select").select,
        swap = require("jrasmusbm.treesitter.swap").swap,
        move = require("jrasmusbm.treesitter.move").move,
      },
    }
  end,
}
