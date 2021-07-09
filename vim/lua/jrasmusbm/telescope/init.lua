local actions = require("telescope.actions")

require('telescope').setup{
  defaults = {
    prompt_position = "top",
    sorting_strategy = "ascending",
    file_sorter =  require'telescope.sorters'.get_fzy_sorter,
    file_ignore_patterns = {"pack/.*"},
    shorten_path = true,
    width = 0.75,
    preview_cutoff = 120,
    results_height = 1,
    results_width = 0.8,
    mappings = {
      i = {
        ["<C-x>"] = false,
        ["<C-q>"] = actions.send_to_qflist,
      }
    }
  },
  extensions = {
    fzy_native = {
      override_file_sorter = true
    }
  }
}

-- require'telescope.builtin'.find_files({ attach_mappings = function(_, map)
--   -- map('i', '<c-e>', actions) -- this action already exist
--   -- map('n', '<c-d>', actions.git_delete_branch) -- this action already exist
--   -- -- for more actions look at lua/telescope/actions/init.lua
--   return true
-- end})

require("telescope").load_extension("fzy_native")
