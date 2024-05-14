return {
  "vim-test/vim-test",
  lazy = true,
  dependencies = {
    "christoomey/vim-tmux-runner",
  },
  config = function()
    vim.cmd [[
let test#python#project_root = "./tests"
let test#strategy = "vtr"

let test#go#gotest#options = "-cover"
]]

    vim.keymap.set({ "n" }, "<localleader>dn", "<cmd>TestNearest<cr>")
    vim.keymap.set({ "n" }, "<localleader>df", "<cmd>TestFile<cr>")
    vim.keymap.set({ "n" }, "<localleader>ds", "<cmd>TestSuite<cr>")
    vim.keymap.set({ "n" }, "<localleader>dp", "<cmd>TestLast<cr>")
    vim.keymap.set({ "n" }, "<localleader>dv", "<cmd>TestVisit<cr>")
  end,
  keys = {
    "<localleader>dn",
    "<localleader>df",
    "<localleader>ds",
    "<localleader>dp",
    "<localleader>dv",
  },
}
