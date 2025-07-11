vim.g.VtrPercentage = 45
vim.g.VtrOrientation = "h"
vim.g.vtr_filetype_runner_overrides = {
  rust = "cargo run {file}",
  go = "go run {file}",
  terraform = "terraform apply",
}

return {
  "JRasmusBm/nvim-tmux-runner",
  lazy = true,
  dev = true,
  config = function()
    require("nvim-tmux-runner").setup {}
    require("jrasmusbm.tmux").setup()
  end,
  keys = {
    "<localleader>ta",
    "<localleader>ts",
    { "<localleader>ts", mode = "v" },
    "<localleader>tt",
    "<localleader>tf",
    "<localleader>tl",
    "<localleader>tp",
    "<localleader>to",
    "<localleader>tj",
    "<localleader>tc",
    "<localleader>td",
    "<localleader>tv",
  },
}
