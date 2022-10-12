vim.cmd [[
packadd nvim-dap
packadd nvim-dap-ui
packadd nvim-dap-python
packadd nvim-dap-virtual-text
packadd debugpy.nvim
]]
require("nvim-dap-virtual-text").setup {
  all_frames = true,
  highlight_changed_variables = false,
}

require("dapui").setup {
  layouts = {
    elements = {
      { id = "watches", size = 00.25 },
    },
    position = "bottom",
  },
}

require "jrasmusbm.dap.keymaps"
