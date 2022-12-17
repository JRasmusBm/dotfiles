local M = {}

M.find_spoons = function()
  require("telescope.builtin").find_files {
    prompt_title = "Treesitter Queries",
    cwd = vim.fn.getenv "DOTFILES" .. "/window_manager/hammerspoon/",
    attach_mappings = function(prompt_bufnr, map)
      local create_new_spoon = function()
        require("telescope.actions").close(prompt_bufnr)

        local spoon_name = require("telescope.actions.state").get_current_line()
        vim.cmd(
          string.format(
            ":e! %s/window_manager/hammerspoon/%s.spoon/init.lua",
            os.getenv "DOTFILES",
            spoon_name
          )
        )

        vim.fn.system(
          string.format(
            "printf 'hs.loadSpoon(\"%s\")' >> %s/window_manager/hammerspoon/init.lua",
            spoon_name,
            os.getenv "DOTFILES"
          )
        )
      end

      map("i", "<C-e>", create_new_spoon)
      map("n", "<C-e>", create_new_spoon)

      return true
    end,
    path_display = function(opts, path)
      local split_path = vim.split(path, "/")
      local folder = split_path[#split_path - 1]
      local split_folder = vim.split(folder, ".", { plain = true })
      return split_folder[1]
    end,
  }
end

return M
