return {
  "theHamsta/nvim-dap-virtual-text",
  lazy = true,
  dependencies = {
    "mfussenegger/nvim-dap",
  },
  config = function()
    require("nvim-dap-virtual-text").setup {
      all_frames = true,
      highlight_changed_variables = false,
    }
  end,
}
