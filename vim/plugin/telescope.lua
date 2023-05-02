local ensure_setup = require("jrasmusbm.telescope").ensure_setup

vim.api.nvim_create_user_command("THL", function()
  ensure_setup()
  vim.cmd [[ Telescope highlights ]]
end, { nargs = "*" })

vim.keymap.set({ "n" }, "<leader>ff", function()
  ensure_setup()
  local cwd = require("telescope.utils").get_os_command_output({ "cd-root" })[1]

  require("jrasmusbm.telescope.git_files").git_files {
    show_untracked = true,
    cwd=cwd,
    git_command = {
      "git",
      "ls-files",
      "--exclude-standard",
      "--cached",
      cwd,
    },
  }
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>fg", function()
  ensure_setup()
  require("jrasmusbm.telescope.find_files").find_files {
    hidden = true,
    no_ignore = true,
  }
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>fq", function()
  ensure_setup()
  require("telescope.builtin").quickfix()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>fl", function()
  ensure_setup()
  require("telescope.builtin").live_grep()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>fb", function()
  ensure_setup()
  require("telescope.builtin").buffers()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>f:", function()
  ensure_setup()
  require("telescope.builtin").command_history()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>f/", function()
  ensure_setup()
  require("telescope.builtin").search_history()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>fh", function()
  ensure_setup()
  require("telescope.builtin").help_tags()
end, { noremap = true })

-- Git search mappings
vim.api.nvim_create_user_command("GFiles", function()
  ensure_setup()

  require("jrasmusbm.telescope.git_files").git_files { show_untracked = true }
end, { nargs = "*" })

vim.keymap.set({ "n" }, "<localleader>fc", function()
  ensure_setup()
  require("jrasmusbm.telescope.git_commits").git_commits()
end)

vim.keymap.set({ "n" }, "<localleader>fi", function()
  ensure_setup()
  require("jrasmusbm.telescope.git_issues").git_issues()
end)

vim.keymap.set({ "n" }, "<localleader>fp", function()
  ensure_setup()
  require("jrasmusbm.telescope.git_pull_requests").git_pull_requests()
end)

vim.keymap.set({ "n" }, "<localleader>fb", function()
  ensure_setup()
  require("jrasmusbm.telescope.git_branches").git_branches()
end)

vim.keymap.set({ "n" }, "<localleader>fs", function()
  ensure_setup()
  require("telescope.builtin").git_status()
end)

-- Config files

vim.keymap.set({ "n" }, "<leader>ea", function()
  ensure_setup()
  require("jrasmusbm.telescope.find_files").find_files {
    prompt_title = "All Files",
    cwd = vim.fn.getenv "DOTFILES" .. "/vim/after/",
  }
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>eu", function()
  ensure_setup()
  require("jrasmusbm.telescope.find_files").find_files {
    prompt_title = "Autoload Files",
    cwd = vim.fn.getenv "DOTFILES" .. "/vim/autoload/",
  }
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>el", function()
  ensure_setup()
  require("jrasmusbm.telescope.find_files").find_files {
    prompt_title = "Lua Files",
    cwd = vim.fn.getenv "DOTFILES" .. "/vim/lua/jrasmusbm/",
  }
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>e.", function()
  ensure_setup()
  require("jrasmusbm.telescope.find_files").find_files {
    prompt_title = "All Dotfiles",
    cwd = vim.fn.getenv "DOTFILES",
  }
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>es", function()
  ensure_setup()
  require("jrasmusbm.telescope.find_files").find_files {
    prompt_title = "Snippet Files",
    cwd = vim.fn.getenv "DOTFILES" .. "/vim/lua/jrasmusbm/snippets/shared/",
  }
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>eb", function()
  ensure_setup()
  require("jrasmusbm.telescope.find_files").find_files {
    prompt_title = "Scripts",
    cwd = vim.fn.getenv "DOTFILES" .. "/bin",
  }
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>er", function()
  ensure_setup()
  require("jrasmusbm.telescope.find_files").find_files {
    prompt_title = "Bin Source",
    cwd = vim.fn.getenv "DOTFILES" .. "/bin-src",
  }
end, { noremap = true })


vim.keymap.set({ "n" }, "<leader>em", function()
  ensure_setup()
  require("telescope.builtin").keymaps()
end, { noremap = true })


vim.keymap.set({ "n" }, "<leader>ec", function()
  ensure_setup()
  require("jrasmusbm.telescope.find_files").find_files {
    prompt_title = "Zsh Completion Files",
    cwd = vim.fn.getenv "DOTFILES" .. "/shell/zsh_completions",
  }
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>ei", function()
  ensure_setup()
  require("jrasmusbm.telescope.find_files").find_files {
    prompt_title = "Install Dependencies",
    cwd = vim.fn.getenv "DOTFILES" .. "/install_dependencies",
  }
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>ef", function()
  ensure_setup()
  require("jrasmusbm.telescope.find_files").find_files {
    prompt_title = "Filetype Config Files",
    cwd = vim.fn.getenv "DOTFILES" .. "/vim/ftplugin/",
  }
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>ep", function()
  ensure_setup()
  require("jrasmusbm.telescope.find_files").find_files {
    prompt_title = "Plugin Files",
    cwd = vim.fn.getenv "DOTFILES" .. "/vim/plugin/",
  }
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>eq", function()
  ensure_setup()
  require("jrasmusbm.telescope.find_files").find_files {
    prompt_title = "Treesitter Queries",
    cwd = vim.fn.getenv "DOTFILES" .. "/vim/queries/",
  }
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>eh", function()
  ensure_setup()
  require("jrasmusbm.telescope.hammerspoon").find_spoons()
end, { noremap = true })


vim.keymap.set({ "i" }, "<C-\\><C-I>", function()
  ensure_setup()
  require("jrasmusbm.telescope.git_issues").git_issues()
end, {})

vim.keymap.set({ "i" }, "<C-\\><C-P>", function()
  ensure_setup()
  require("jrasmusbm.telescope.git_pull_requests").git_pull_requests()
end, {})

vim.keymap.set({ "i" }, "<C-\\><C-F>", function()
  ensure_setup()

  local pwd = require("telescope.utils").get_os_command_output { "cd-root" }
  require("jrasmusbm.telescope.git_files").git_files {
    show_untracked = true,
    git_command = {
      "git",
      "ls-files",
      "--exclude-standard",
      "--cached",
      pwd,
    },
  }
end, {})

vim.keymap.set({ "i" }, "<C-\\><C-H>", function()
  ensure_setup()
  require("telescope.builtin").help_tags()
end, {})
