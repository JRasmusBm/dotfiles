local filetype_to_parsername =
  require("nvim-treesitter.parsers").filetype_to_parsername

for target, sources in pairs(require "jrasmusbm.filetypes") do
  for _, source in ipairs(sources) do
    if source ~= target then
      filetype_to_parsername[source] = target
    end
  end
end

require("nvim-treesitter.configs").setup {
  highlight = { enable = true, disable = { "markdown" } },
  playground = require("jrasmusbm.treesitter.playground").playground,
  query_linter = require("jrasmusbm.treesitter.query_linter").query_linter,
  textobjects = {
    select = require("jrasmusbm.treesitter.select").select,
    swap = require("jrasmusbm.treesitter.swap").swap,
    move = require("jrasmusbm.treesitter.move").move,
  },
}
