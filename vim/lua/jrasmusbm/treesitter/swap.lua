local M = {}

M.swap = {
  enable = true,
  swap_next = {["]a"] = "@parameter.inner", ["]E"] = "@statement.outer"},
  swap_previous = {["[a"] = "@parameter.inner", ["[E"] = "@statement.outer"},
}

return M
