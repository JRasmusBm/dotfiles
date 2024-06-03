return {
  "vim-test/vim-test",
  lazy = true,
  dependencies = {
    "JRasmusBm/nvim-tmux-runner",
  },
  config = function()
    require("jrasmusbm.test").setup()
  end,
  keys = {
    "<localleader>dn",
    "<localleader>df",
    "<localleader>ds",
    "<localleader>dp",
    "<localleader>dv",
  },
}
