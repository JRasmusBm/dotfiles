return {
  "sindrets/diffview.nvim",
  lazy = true,
  config = function()
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

    vim.api.nvim_create_user_command("DC", "DiffviewClose", { nargs = "*" })
    vim.api.nvim_create_user_command("DO", function(options)
      local args = options.fargs

      if #options.fargs <= 0 then
        args = {
          vim.trim(vim.fn.system "git merge-base `git local-main-branch` HEAD"),
        }
      end

      vim.cmd { cmd = "DiffviewOpen", args = args }
    end, { nargs = "*" })
    vim.api.nvim_create_user_command(
      "DFH",
      "DiffviewFileHistory",
      { nargs = "*" }
    )
  end,
  cmd = {
    "DO",
    "DC",
    "DFH",
  },
}
