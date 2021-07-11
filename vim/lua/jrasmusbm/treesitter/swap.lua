local M = {}

M.swap = {
  enable = true,
  swap_next = {["]a"] = "@parameter.inner"},
  swap_previous = {["[a"] = "@parameter.inner"}
}

return M
