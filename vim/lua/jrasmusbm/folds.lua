local M = {}

M.fold_selection = require("jrasmusbm.utils.mappings").with_textobject(
  function(start_position, end_position)
    vim.api.nvim_buf_set_lines(
      0,
      start_position[1] - 1,
      start_position[1] - 1,
      false,
      { string.format(vim.bo.commentstring, " {{{") }
    )
    vim.api.nvim_buf_set_lines(
      0,
      end_position[1] + 1,
      end_position[1] + 1,
      false,
      { string.format(vim.bo.commentstring, "}}}") }
    )
    vim.api.nvim_win_set_cursor(
      0,
      { start_position[1], #vim.bo.commentstring - 2 }
    )
    vim.cmd.startinsert()
  end
)

return M
