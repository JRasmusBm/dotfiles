local M = {}

M.strategy = function(cmd)
  local cmds = { cmd }

  if not require("jrasmusbm.compat").in_termux() then
    table.insert(
      cmds,
      "if test $? = 0 ; then ;"
      .. "nr -c 'lua vim.notify(\"Passed!\")' ;"
      .. "else ;"
      .. "nr -c 'lua vim.notify(\"Failed!\", 4)' ;"
      .. "fi"
    )
  end

  require("nvim-tmux-runner").send_lines_to_runner(cmds)
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
