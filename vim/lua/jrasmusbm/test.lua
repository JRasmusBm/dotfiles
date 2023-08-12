local M = {}

M.ensure_setup = function()
  require("jrasmusbm.tmux").ensure_setup()
  if not require("jrasmusbm.utils").ensure_setup "vim-test" then
    return false
  end

  vim.cmd [[
let test#python#project_root = "./tests"
let test#strategy = "vtr"

let test#go#gotest#options = "-cover"
]]
end

return M
