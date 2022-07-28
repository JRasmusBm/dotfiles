local M = {}

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local extract_paste_value = function(selection)
  if type(selection[1]) == "string" then
    return selection[1]
  end

  return selection.paste_value or selection.id or selection.name
end

local inject_substring = function(original, substring, index)
  local after_index = ""
  local until_index = ""

  if index == 1 then
    after_index = original
  elseif index == #original then
    until_index = original
  else
    until_index = string.sub(original, 1, index)
    after_index = string.sub(original, index + 1, #original + 5)
  end

  return until_index .. substring .. after_index
end

M.paste = function(prompt_bufnr)
  local selection = action_state.get_selected_entry()
  actions.close(prompt_bufnr)
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor[1], cursor[2]

  local paste_value = extract_paste_value(selection)
  local current_line = vim.api.nvim_buf_get_lines(0, row - 1, row, true)[1]

  local updated_line = inject_substring(current_line, paste_value, col + 1)

  vim.api.nvim_buf_set_lines(0, row - 1, row, true, { updated_line })
  local new_column = col + #paste_value + 1
  vim.api.nvim_win_set_cursor(0, { row, new_column })

  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes("<Esc>a", true, false, true),
    "",
    false
  )
end

vim.api.nvim_create_user_command("T", function(opts)
  local command = opts.fargs[1]
  if command[1] ~= ";" then
    command = "<localleader>" .. command
  end

  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes(command, true, false, true),
    "",
    false
  )
end, { nargs = 1 })

vim.keymap.set({ "i" }, "<c-i>", ":T ", {})

return M
