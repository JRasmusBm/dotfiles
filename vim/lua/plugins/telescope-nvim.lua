return {
  "nvim-telescope/telescope.nvim",
  lazy = true,
  config = function()
    local actions = require "telescope.actions"
    local custom_actions = require "jrasmusbm.telescope.custom_actions"

    require("telescope").setup {
      defaults = {
        sorting_strategy = "ascending",
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        file_ignore_patterns = { "pack/.*" },
        path_display = {},
        color_devicons = true,
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
    require("telescope").load_extension "ui-select"
  end,
  dependencies = {
    "nvim-lua/popup.nvim",
    "nvim-telescope/telescope-fzy-native.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  cmd = {
    "THL",
    "GFiles",
    "Noice",
  },
  keys = {
    "<leader>ff",
    "<leader>fg",
    "<leader>fq",
    "<leader>fl",
    "<leader>fb",
    "<leader>f:",
    "<leader>f/",
    "<leader>fh",
    "<localleader>fc",
    "<localleader>fi",
    "<localleader>fp",
    "<localleader>fb",
    "<localleader>fs",
    "<leader>ea",
    "<leader>eu",
    "<leader>el",
    "<leader>ey",
    "<leader>e.",
    "<leader>es",
    "<leader>eb",
    "<leader>er",
    "<leader>em",
    "<leader>ec",
    "<leader>ei",
    "<leader>ef",
    "<leader>ep",
    "<leader>eq",
    "<leader>eh",
    "<C-\\><C-I>",
    "<C-\\><C-P>",
    "<C-\\><C-F>",
    "<C-\\><C-H>",
    "<leader><esc>",
    "<leader>fm",
  },
}
