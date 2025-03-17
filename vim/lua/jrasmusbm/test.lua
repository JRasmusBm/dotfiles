local M = {}

M.strategy = function(cmd)
  require("nvim-tmux-runner").send_lines_to_runner({ cmd })
end

M.setup = function()
  vim.cmd [[
function! NtrStrategy(cmd)
  call luaeval('require("jrasmusbm.test").strategy(_A.cmd)', { "cmd": a:cmd })
endfunction

let g:test#custom_strategies = {'ntr': function('NtrStrategy')}
let g:test#strategy = 'ntr'

let test#python#project_root = "./tests"
let test#go#gotest#options = "-cover"
]]

  vim.keymap.set({ "n" }, "<localleader>dn", "<cmd>TestNearest<cr>")
  vim.keymap.set({ "n" }, "<localleader>df", "<cmd>TestFile<cr>")
  vim.keymap.set({ "n" }, "<localleader>ds", "<cmd>TestSuite<cr>")
  vim.keymap.set({ "n" }, "<localleader>dp", "<cmd>TestLast<cr>")
  vim.keymap.set({ "n" }, "<localleader>dv", "<cmd>TestVisit<cr>")
end

return M
