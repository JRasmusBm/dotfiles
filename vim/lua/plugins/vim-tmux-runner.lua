vim.g.VtrPercentage = 45
vim.g.VtrOrientation = "h"
vim.g.vtr_filetype_runner_overrides = {
  rust = "cargo run {file}",
  go = "go run {file}",
  terraform = "terraform apply",
}

return {
  "christoomey/vim-tmux-runner",
  lazy = true,
  config = function()
    require("jrasmusbm.tmux").setup()

    vim.cmd [[
  silent VtrAttachToPane 1"
  ]]
  end,
  keys = {
    "<localleader>td",
    "<localleader>tc",
    "<localleader>tr",
    "<localleader>ta",
    "<localleader>to",
    "<localleader>ts",
    "<localleader>tk",
    "<localleader>tf",
    "<localleader>tl",
    "<localleader>tp",
    "<localleader>tl",
  },
}
