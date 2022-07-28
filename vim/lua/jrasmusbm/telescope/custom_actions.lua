local M = {}

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local extract_value_to_insert = function(selection)
  if type(selection[1]) == "string" then
    return selection[1]
  end

  return selection.insert_as or selection.id or selection.name
end

local inject_substring = function(original, substring, index)
  if index == 1 then
    return substring .. original
  end
  if index == #original then
    return original .. substring
  end

  return string.sub(original, 1, index)
    .. substring
    .. string.sub(original, index + 1, #original + 2)
end

local feedkeys = function(keys)
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes(keys, true, false, true),
    "",
    false
  )
end

local move_cursor_in_insert_mode = function(row, col, column_steps)
  local new_column = col + column_steps

  if col > 0 then
    new_column = new_column + 1
  end

  vim.api.nvim_win_set_cursor(0, { row, new_column })

  feedkeys "<Esc>a"
end

-- Enters insert mode and inserts the current selection.
-- The value to insert is determined in the following order:
--   1. If the selection is a string, insert that string
--   2. The `insert_as` field, if set.
--   2. The `id` field, if set.
--   4. The `name` field, if set.
M.insert_selection = function(prompt_bufnr)
  actions.close(prompt_bufnr)

  local cursor = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor[1], cursor[2]

  local selection = action_state.get_selected_entry()
  local value_to_insert = extract_value_to_insert(selection)
  local current_line = vim.api.nvim_buf_get_lines(0, row - 1, row, true)[1]

  local updated_line = inject_substring(current_line, value_to_insert, col + 1)
  vim.api.nvim_buf_set_lines(0, row - 1, row, true, { updated_line })

  move_cursor_in_insert_mode(row, col, #value_to_insert)
end

return M
