local M = {}

M.move = {
    enable = true,
    set_jumps = true,
    goto_next_start = {["]m"] = "@function.outer"},
    goto_next_end = {["]M"] = "@function.outer"},
    goto_previous_start = {["[m"] = "@function.outer"},
    goto_previous_end = {["[M"] = "@function.outer"}
}

return M
