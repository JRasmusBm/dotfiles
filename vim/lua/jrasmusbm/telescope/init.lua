vim.cmd [[
packadd telescope-dap.nvim
packadd telescope-ui-select.nvim
]]

local actions = require "telescope.actions"
local custom_actions = require "jrasmusbm.telescope.custom_actions"
local feedkeys = require("jrasmusbm.utils.mappings").feedkeys

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

vim.api.nvim_create_user_command("T", function(opts)
  local command = opts.fargs[1]
  if command[1] ~= ";" then
    command = "<localleader>" .. command
  end

  feedkeys(command)
end, { nargs = 1 })

vim.keymap.set({ "i" }, "<C-\\>", ":T ", {})

if not require("jrasmusbm.compat").in_termux() then
  require("telescope").load_extension "fzy_native"
end
require("telescope").load_extension "dap"
require("telescope").load_extension "ui-select"

require("jrasmusbm.dap.keymaps").telescope_mappings()
