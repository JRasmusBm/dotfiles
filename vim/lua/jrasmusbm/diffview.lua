vim.cmd [[
packadd! diffview.nvim

cabbr DO DiffviewOpen
cabbr DC DiffviewClose
]]

local cb = require("diffview.config").diffview_callback

require("diffview").setup {
  key_bindings = {
    view = {
      ["R"] = cb "refresh_files",
      ["-"] = cb "toggle_stage_entry",
      ["gq"] = cb "close",
    },
    file_panel = {
      ["j"] = cb "next_entry",
      ["k"] = cb "prev_entry",
      ["<cr>"] = cb "select_entry",
      ["o"] = cb "select_entry",
      ["R"] = cb "refresh_files",
    },
  },
}
