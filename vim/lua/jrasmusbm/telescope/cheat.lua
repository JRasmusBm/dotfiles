local M = {}

local Job = require "plenary.job"
local utils = require "telescope.utils"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local previewers = require "telescope.previewers"

local cheat_bufnr = nil

local function update_bufnr()
  if cheat_bufnr == nil then
    cheat_bufnr = vim.api.nvim_create_buf(false, true)
  end
end

local function cheat_show(path)
  local command = vim.list_extend({ "cheat", "-T", "s" }, path)
  return utils.get_os_command_output(command)
end

local function cheat_list(path)
  return utils.get_os_command_output(vim.list_extend({ "cheat", "l" }, path))
end

M.cheat = function(path)
  local current_path = path or {}

  if type(current_path) == "string" then
    current_path = vim.split(current_path, " ")
  end

  local results = cheat_list(current_path)

  pickers.new({}, {
    prompt_title = "cheat.sh",
    layout_config = { width = 0.8, preview_width = 0.8 },
    finder = finders.new_table {
      results = results,
      entry_maker = function(line)
        return { value = line, ordinal = line, display = line }
      end,
    },
    previewer = previewers.new_termopen_previewer {
      title = "Preview",
      get_command = function(entry)
        return vim.list_extend(vim.list_extend({ "cheat" }, current_path), { entry.value })
      end,
    },
    sorter = sorters.get_generic_fuzzy_sorter(),
    attach_mappings = function(prompt_bufnr, map)
      local show = function()
        update_bufnr()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        table.insert(current_path, selection.value)
        local output = cheat_show(current_path)
        vim.api.nvim_buf_set_lines(cheat_bufnr, 0, -1, false, output)
        vim.api.nvim_win_set_buf(0, cheat_bufnr)
      end

      local up = function()
        actions.close(prompt_bufnr)

        table.remove(current_path, #current_path)
        M.cheat(current_path)
      end

      local list = function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        table.insert(current_path, selection.value)
        M.cheat(current_path)
      end

      map("i", "<leader>s", show)
      map("n", "<leader>s", show)

      map("i", "<c-o>", up)
      map("n", "<c-o>", up)

      actions.select_default:replace(list)
      return true
    end,
  }):find()
end

return M
