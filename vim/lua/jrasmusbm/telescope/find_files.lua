local M = {}

M.find_files = function(options)
  require("telescope.builtin").find_files {
    cwd = options.cwd,
    prompt_title = options.prompt_title,
    attach_mappings = function(prompt_bufnr, map)
      local create_new_file = require("jrasmusbm.telescope.create_new_file").create_new_file(options, prompt_bufnr)

      map("i", "<C-e>", create_new_file)
      map("n", "<C-e>", create_new_file)

      return true
    end,
  }
end

return M
