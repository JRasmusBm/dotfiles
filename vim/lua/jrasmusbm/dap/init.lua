vim.cmd [[
packadd! nvim-dap
packadd! nvim-dap-ui
packadd! nvim-dap-python
packadd! nvim-dap-virtual-text
packadd! debugpy.nvim
]]
require "jrasmusbm.dap.python"

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

vim.keymap.set({ "n" }, "<leader>ic", function()
  require("dap").continue()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>i<Esc>", function()
  require("dap").disconnect()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>ik", function()
  require("dap").step_back()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>il", function()
  require("dap").step_into()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>ih", function()
  require("dap").step_out()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>ij", function()
  require("dap").step_over()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>ir", function()
  require("dap").run_last()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>iu", function()
  require("dapui").toggle()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>ib", function()
  require("dap").toggle_breakpoint()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>iq", function()
  require("dap").list_breakpoints()
end, { noremap = true })
