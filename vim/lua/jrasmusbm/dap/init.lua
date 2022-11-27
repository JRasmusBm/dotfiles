local M = {}

M.ensure_setup = function()
  if not require("jrasmusbm.utils").ensure_setup "nvim-dap" then
    return false
  end

  require("jrasmusbm.utils").ensure_setup "nvim-dap-ui"
  require("jrasmusbm.utils").ensure_setup "nvim-dap-virtual-text"
  require("jrasmusbm.utils").ensure_setup "debugpy.nvim"
require("jrasmusbm.telescope").ensure_setup()
  require("telescope").load_extension "dap"

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

  return true
end

return M
