return {
  "mfussenegger/nvim-dap",
  lazy = true,
  config = function()
    require("telescope").load_extension "dap"
  end,
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-dap.nvim",
  },
}
