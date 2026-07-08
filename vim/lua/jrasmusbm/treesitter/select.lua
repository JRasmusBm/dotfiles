local M = {}

M.select = {
  enable = true,
  lookahead = true,
  keymaps = {
    ["af"] = "@function.outer",
    ["if"] = "@function.inner",
    [";dc"] = "@test.case.outer",
    [";ds"] = "@test.suite.outer",
    [";s"] = "@statement.outer",
    [";a"] = "@argument.inner",
  },
}

return M
