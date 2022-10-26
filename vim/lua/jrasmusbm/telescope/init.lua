local M = {}

M.ensure_setup = function()
  print(
    vim.inspect({
      file = "vim/lua/jrasmusbm/telescope/init.lua",
      line = 10,
      
    })
  )
  if not require("jrasmusbm.utils").ensure_loaded "telescope.nvim" then
    return
  end

  print(
    vim.inspect({
      file = "/home/jrasmusbm/dotfiles/vim/lua/jrasmusbm/telescope/init.lua",
      line = 14,
      
    })
  )
  require("jrasmusbm.utils").ensure_loaded "popup.nvim"
  require("jrasmusbm.utils").ensure_loaded "plenary.nvim"
  require("jrasmusbm.utils").ensure_loaded "telescope-dap.nvim"
  require("jrasmusbm.utils").ensure_loaded "telescope-ui-select.nvim"
  require("jrasmusbm.utils").ensure_loaded "telescope-fzy-native.nvim"

  local actions = require "telescope.actions"
  local custom_actions = require "jrasmusbm.telescope.custom_actions"

  require("telescope").setup {
    defaults = {
      sorting_strategy = "ascending",
      file_sorter = require("telescope.sorters").get_fzy_sorter,
      file_ignore_patterns = { "pack/.*" },
      path_display = {},
      layout_config = {
        prompt_position = "top",
        width = 0.75,
        preview_cutoff = 120,
      },
      mappings = {
        i = {
          ["<C-x>"] = false,
          ["<C-q>"] = actions.send_to_qflist,
          ["<c-\\>"] = custom_actions.insert_selection,
        },
        n = {
          ["<c-r>"] = require("jrasmusbm.telescope.refresh").refresh,
          ["<C-q>"] = actions.send_to_qflist,
          ["<c-\\>"] = custom_actions.insert_selection,
        },
      },
    },
    extensions = {
      fzy_native = { override_file_sorter = true },
      ["ui-select"] = {
        require("telescope.themes").get_dropdown {
          -- even more opts
        },
      },
    },
  }

  if not require("jrasmusbm.compat").in_termux() then
    require("telescope").load_extension "fzy_native"
  end
  require("telescope").load_extension "dap"
  require("telescope").load_extension "ui-select"

  require("jrasmusbm.dap.keymaps").telescope_mappings()
end

return M
