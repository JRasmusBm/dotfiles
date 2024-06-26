local M = {}

local action_state = require "telescope.actions.state"
local actions = require "telescope.actions"

M.git_branches = function(options_)
  local options = options_ or {}
  options["attach_mappings"] = function(prompt_bufnr, map)
    local reset_hard = function()
      local selection = action_state.get_selected_entry()
      vim.api.nvim_command("Git rh " .. selection.value)
      actions.close(prompt_bufnr)
      require("jrasmusbm.git").list_tree()
    end

    local switch = function()
      actions.git_checkout(prompt_bufnr)
      require("jrasmusbm.git").list_tree()
    end

    local track = function()
      actions.git_track_branch(prompt_bufnr)
      require("jrasmusbm.git").list_tree()
    end

    local delete_local = function()
      actions.git_delete_branch(prompt_bufnr)
      require("jrasmusbm.git").list_tree()
    end

    local delete_remote = function()
      local selection = action_state.get_selected_entry()
      vim.api.nvim_command(
        "Git pd " .. selection.value:gsub("^origin/", "origin ")
      )
      require("jrasmusbm.git").list_tree()
    end

    local fast_forward = function()
      local selection = action_state.get_selected_entry()
      vim.api.nvim_command("Git ff " .. selection.value)
      actions.close(prompt_bufnr)
      require("jrasmusbm.git").list_tree()
    end

    map("i", "<C-h>", reset_hard)
    map("n", "<C-h>", reset_hard)
    map("i", "<CR>", switch)
    map("n", "<CR>", switch)
    map("i", "<C-d>", delete_local)
    map("n", "<C-d>", delete_local)
    map("i", "<C-p>", delete_remote)
    map("n", "<C-p>", delete_remote)
    map("i", "<C-t>", track)
    map("n", "<C-t>", track)
    map("i", "<C-f>", fast_forward)
    map("n", "<C-f>", fast_forward)

    return true
  end

  require("telescope.builtin").git_branches(options)
end

return M
