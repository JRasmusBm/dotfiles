local M = {}

M.swap = {
  enable = true,
  swap_next = {["]p"] = "@parameter.inner"},
  swap_previous = {["[p"] = "@parameter.inner"}
}

return M
