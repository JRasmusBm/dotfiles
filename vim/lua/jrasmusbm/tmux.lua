local M = {}

local state = { already_setup = false }

M.ensure_setup = function()
  if not state.already_setup then
    vim.g.VtrPercentage = 45
    vim.g.VtrOrientation = "h"
    vim.g.vtr_filetype_runner_overrides = {
      rust = "cargo run {file}",
      go = "go run {file}",
    }
    state.already_setup = true
  end

  require("jrasmusbm.utils").ensure_setup "vim-tmux-runner"

  vim.cmd [[
  silent VtrAttachToPane 1"
  ]]
end

return M
