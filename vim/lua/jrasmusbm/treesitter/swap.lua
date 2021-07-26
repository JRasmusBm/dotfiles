local M = {}

M.swap = {
  enable = true,
  swap_next = {["]a"] = "@argument.inner", ["]E"] = "@statement.outer"},
  swap_previous = {["[a"] = "@argument.inner", ["[E"] = "@statement.outer"},
}

return M
