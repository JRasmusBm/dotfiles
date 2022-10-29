local M = {}


M.ensure_setup = function()
if require("jrasmusbm.utils").ensure_setup("diffview.nvim") then
 return 
end

  vim.api.nvim_create_user_command("DC", function(_, fargs)
    vim.cmd { cmd = "DiffviewClose", args = fargs }
  end, { nargs = "*" })

  local cb = require("diffview.config").diffview_callback

  require("diffview").setup {
    enhanced_diff_hl = true,
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
  
end

return M
