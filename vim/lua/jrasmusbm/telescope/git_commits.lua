local M = {}

local action_state = require "telescope.actions.state"
local actions = require "telescope.actions"

M.git_commits = function(options_)
  local options = options_ or {}
  options["attach_mappings"] = function(prompt_bufnr, map)
    local reset_hard = function()
      local selection = action_state.get_selected_entry()
      vim.api.nvim_command("Git rh " .. selection.value)
      actions.close(prompt_bufnr)
      require("jrasmusbm.git").list_tree()
    end

    local rebase_interactive = function()
      local selection = action_state.get_selected_entry()
      vim.api.nvim_command("G rbi " .. selection.value)
    end

    local browse = function()
      local selection = action_state.get_selected_entry()

      vim.api.nvim_command("G browse " .. selection.value)
    end

    map("i", "<C-h>", reset_hard)
    map("n", "<C-h>", reset_hard)

    map("i", "<C-b>", browse)
    map("n", "<C-b>", browse)

    map("i", "<C-i>", rebase_interactive)
    map("n", "<C-i>", rebase_interactive)

    return true
  end

  require("telescope.builtin").git_commits(options)
end

return M
