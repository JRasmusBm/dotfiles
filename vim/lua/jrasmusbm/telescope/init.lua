local actions = require("telescope.actions")

require('telescope').setup {
    defaults = {
        sorting_strategy = "ascending",
        file_sorter = require'telescope.sorters'.get_fzy_sorter,
        file_ignore_patterns = {"pack/.*"},
        path_display = {},
        layout_config = {
            prompt_position = "top",
            width = 0.75,
            preview_cutoff = 120
        },
        mappings = {
            i = {["<C-x>"] = false, ["<C-q>"] = actions.send_to_qflist},
            n = {
                ["<c-r>"] = require("jrasmusbm.telescope.refresh").refresh,
                ["<C-q>"] = actions.send_to_qflist
            }

        }
    },
    extensions = {fzy_native = {override_file_sorter = true}}
}

require("telescope").load_extension("fzy_native")
require("telescope").load_extension("dap")
