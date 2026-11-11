-- Keymaps call into telescope lazily: requiring it here cost ~25ms of
-- every nvim start.
local function lazy(mod, fn)
  return function(...)
    return require(mod)[fn](...)
  end
end

-- ui-select replaces vim.ui.select when telescope loads; load it on the
-- first select instead of at start.
vim.ui.select = function(...)
  require "telescope"
  return vim.ui.select(...)
end

vim.api.nvim_create_user_command("THL", function()
  vim.cmd [[ Telescope highlights ]]
end, { nargs = "*" })

vim.keymap.set({ "n" }, "<leader>ff", function()
  local cwd = require("telescope.utils").get_os_command_output({ "cd-root" })[1]

  require("jrasmusbm.telescope.git_files").git_files {
    show_untracked = true,
    cwd = cwd,
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
  require("jrasmusbm.telescope.find_files").find_files {
    hidden = true,
    no_ignore = true,
  }
end, { noremap = true })

vim.keymap.set(
  { "n" },
  "<leader>fq",
  lazy("telescope.builtin", "quickfix"),
  { noremap = true }
)

vim.keymap.set(
  { "n" },
  "<leader>fl",
  lazy("telescope.builtin", "live_grep"),
  { noremap = true }
)

vim.keymap.set(
  { "n" },
  "<leader>fb",
  lazy("telescope.builtin", "buffers"),
  { noremap = true }
)

vim.keymap.set(
  { "n" },
  "<leader>f:",
  lazy("telescope.builtin", "command_history"),
  { noremap = true }
)

vim.keymap.set(
  { "n" },
  "<leader>f/",
  lazy("telescope.builtin", "search_history"),
  { noremap = true }
)

vim.keymap.set(
  { "n" },
  "<leader>fh",
  lazy("telescope.builtin", "help_tags"),
  { noremap = true }
)

-- Git search mappings
vim.api.nvim_create_user_command("GFiles", function()
  require("jrasmusbm.telescope.git_files").git_files { show_untracked = true }
end, { nargs = "*" })

vim.keymap.set(
  { "n" },
  "<localleader>fc",
  lazy("jrasmusbm.telescope.git_commits", "git_commits")
)

vim.keymap.set(
  { "n" },
  "<localleader>fi",
  lazy("jrasmusbm.telescope.git_issues", "git_issues")
)

vim.keymap.set(
  { "n" },
  "<localleader>fp",
  lazy("jrasmusbm.telescope.git_pull_requests", "git_pull_requests")
)

vim.keymap.set({ "n" }, "<localleader>fb", function()
  require("jrasmusbm.telescope.git_branches").git_branches {
    show_remote_tracking_branches = false,
  }
end
)

vim.keymap.set(
  { "n" },
  "<localleader>fs",
  lazy("telescope.builtin", "git_status")
)

-- Config files

vim.keymap.set({ "n" }, "<leader>eu", function()
  require("jrasmusbm.telescope.find_files").find_files {
    prompt_title = "Lua Files",
    cwd = vim.fn.getenv "DOTFILES" .. "/vim/lua/jrasmusbm/",
  }
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>ey", function()
  require("jrasmusbm.telescope.find_files").find_files {
    prompt_title = "Lua Files",
    cwd = vim.fn.getenv "DOTFILES" .. "/vim/lua/plugins/",
  }
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>e.", function()
  require("jrasmusbm.telescope.find_files").find_files {
    prompt_title = "All Dotfiles",
    cwd = vim.fn.getenv "DOTFILES",
  }
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>es", function()
  require("jrasmusbm.telescope.find_files").find_files {
    prompt_title = "Snippet Files",
    cwd = vim.fn.getenv "DOTFILES" .. "/vim/lua/jrasmusbm/snippets/shared/",
  }
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>eb", function()
  require("jrasmusbm.telescope.find_files").find_files {
    prompt_title = "Scripts",
    cwd = vim.fn.getenv "DOTFILES" .. "/bin",
  }
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>er", function()
  require("jrasmusbm.telescope.find_files").find_files {
    prompt_title = "Bin Source",
    cwd = vim.fn.getenv "DOTFILES" .. "/bin-src",
  }
end, { noremap = true })

vim.keymap.set(
  { "n" },
  "<leader>em",
  lazy("telescope.builtin", "keymaps"),
  { noremap = true }
)

vim.keymap.set({ "n" }, "<leader>ec", function()
  require("jrasmusbm.telescope.find_files").find_files {
    prompt_title = "Zsh Completion Files",
    cwd = vim.fn.getenv "DOTFILES" .. "/shell/zsh_completions",
  }
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>ei", function()
  require("jrasmusbm.telescope.find_files").find_files {
    prompt_title = "Install Dependencies",
    cwd = vim.fn.getenv "DOTFILES" .. "/install_dependencies",
  }
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>ef", function()
  require("jrasmusbm.telescope.find_files").find_files {
    prompt_title = "Filetype Config Files",
    cwd = vim.fn.getenv "DOTFILES" .. "/vim/after/ftplugin/",
  }
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>ep", function()
  require("jrasmusbm.telescope.find_files").find_files {
    prompt_title = "Plugin Files",
    cwd = vim.fn.getenv "DOTFILES" .. "/vim/after/plugin/",
  }
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>eq", function()
  require("jrasmusbm.telescope.find_files").find_files {
    prompt_title = "Treesitter Queries",
    cwd = vim.fn.getenv "DOTFILES" .. "/vim/queries/",
  }
end, { noremap = true })

vim.keymap.set(
  { "n" },
  "<leader>eh",
  lazy("jrasmusbm.telescope.hammerspoon", "find_spoons"),
  { noremap = true }
)

vim.keymap.set(
  { "i" },
  "<C-\\><C-I>",
  lazy("jrasmusbm.telescope.git_issues", "git_issues"),
  {}
)

vim.keymap.set(
  { "i" },
  "<C-\\><C-P>",
  lazy("jrasmusbm.telescope.git_pull_requests", "git_pull_requests"),
  {}
)

vim.keymap.set({ "i" }, "<C-\\><C-F>", function()
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

vim.keymap.set(
  { "i" },
  "<C-\\><C-H>",
  lazy("telescope.builtin", "help_tags"),
  {}
)
