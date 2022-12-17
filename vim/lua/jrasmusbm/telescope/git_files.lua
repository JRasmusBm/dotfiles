local M = {}

M.git_files = function(options)
  options = options or {}

  if options.use_git_root == nil then
    options.use_git_root = true
  end

  if options.show_untracked == nil then
    options.show_untracked = true
  end

  options.attach_mappings = function(prompt_bufnr, map)
    local create_new_file =
      require("jrasmusbm.telescope.create_new_file").create_new_file(
        options or {},
        prompt_bufnr
      )

    map("i", "<C-e>", create_new_file)
    map("n", "<C-e>", create_new_file)

    return true
  end

  require("telescope.builtin").git_files(options)
end

return M
