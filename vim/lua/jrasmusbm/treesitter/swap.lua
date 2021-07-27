local M = {}

M.swap = {
  enable = true,
  swap_next = {["]a"] = "@argument.inner", ["]S"] = "@statement.outer"},
  swap_previous = {["[a"] = "@argument.inner", ["[S"] = "@statement.outer"},
}

return M
