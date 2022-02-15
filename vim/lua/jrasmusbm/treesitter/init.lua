require("jrasmusbm.treesitter.parsers")

require"nvim-treesitter.configs".setup {
  ensure_installed = "maintained",
  highlight = {enable = true, disable = {"markdown"}},
  playground = require("jrasmusbm.treesitter.playground").playground,
  query_linter = require("jrasmusbm.treesitter.query_linter").query_linter,
  textobjects = {
    select = require("jrasmusbm.treesitter.select").select,
    swap = require("jrasmusbm.treesitter.swap").swap,
    move = require("jrasmusbm.treesitter.move").move,
  },
}
