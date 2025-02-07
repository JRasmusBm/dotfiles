return {
  "dpayne/CodeGPT.nvim",
  lazy = true,
  enabled = vim.loop.os_uname().sysname == "Darwin",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require "codegpt.config"
    require("jrasmusbm.gpt.setup").setup()
  end,
  cmd = { "Chat" },
}
