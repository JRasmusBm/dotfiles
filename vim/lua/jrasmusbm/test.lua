local M = {}

M.ensure_setup = function()
  if not require("jrasmusbm.utils").ensure_setup "vim-test" then
    return false
  end

  vim.cmd [[
let test#python#project_root = "./tests"
let test#strategy = "vtr"

let test#go#gotest#options = "-cover"
let test#javascript#reactscripts#options = "--coverage --watchAll=false"
]]
end

return M
