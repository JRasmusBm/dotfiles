vim.cmd [[
packadd! nvim-dap
packadd! nvim-dap-ui
packadd! nvim-dap-python
packadd! nvim-dap-virtual-text
packadd! debugpy.nvim
]]
require("nvim-dap-virtual-text").setup {
  all_frames = true,
  highlight_changed_variables = false,
}

require("dapui").setup {
  sidebar = {
    elements = {
      { id = "stacks", size = 0.25 },
      {
        id = "scopes",
        size = 0.25, -- Can be float or integer > 1
      },
      { id = "watches", size = 00.25 },
      { id = "breakpoints", size = 0.25 },
    },
  },
}

require "jrasmusbm.dap.keymaps"
