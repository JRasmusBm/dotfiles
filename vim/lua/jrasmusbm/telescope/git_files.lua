local M = {}

M.git_files = function(options)
  options = options or {}

  require("telescope.builtin").git_files {
    use_git_root = options.use_git_root or true,
    show_untracked = options.show_untracked or true,
    attach_mappings = function(prompt_bufnr, map)
      local create_new_file = require("jrasmusbm.telescope.create_new_file").create_new_file(
        options or {},
        prompt_bufnr
      )

      map("i", "<C-e>", create_new_file)
      map("n", "<C-e>", create_new_file)

      return true
    end,
  }
end

return M
