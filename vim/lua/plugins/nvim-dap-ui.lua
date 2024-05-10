return {
  "mfussenegger/nvim-dap-ui",
  lazy = true,
  dependencies = {
    "mfussenegger/nvim-dap",
  },
  config = function()
    require("dapui").setup {
      layouts = {
        elements = {
          { id = "watches", size = 00.25 },
        },
        position = "bottom",
      },
    }
  end,
}
