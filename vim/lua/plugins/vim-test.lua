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
  end,
  cmd = {
    "TestNearest",
    "TestFile",
    "TestSuite",
    "TestLast",
    "TestVisit",
  },
}
