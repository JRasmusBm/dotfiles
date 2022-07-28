local mappings = require "jrasmusbm.utils.mappings"

vim.cmd [[
packadd popup.nvim
packadd plenary.nvim
packadd telescope.nvim
packadd telescope-fzy-native.nvim
packadd loupe
packadd vcs-jump
]]

require "jrasmusbm.telescope"

vim.g.LoupeCaseSettingsAlways = 1

mappings.nmap("gs", ':%s/<c-r>=expand("<cword>")<cr>/')

mappings.nmap(
  "*",
  "<Plug>(LoupeStar)<cmd>lua require('jrasmusbm.search').set_search_as_x()<CR>",
  { silent = true }
)
mappings.nmap(
  "#",
  "<Plug>(LoupeOctothorpe)<cmd>lua require('jrasmusbm.search').set_search_as_x()<CR>",
  { silent = true }
)

mappings.nmap("<Leader> fc", "<cmd>Cheat<CR>", { noremap = true })

-- Vim search mappings
mappings.nmap(
  "<leader>ff",
  "<cmd>lua require('jrasmusbm.telescope.git_files').git_files({ show_untracked = true })<cr>",
  { noremap = true }
)
mappings.nmap(
  "<leader>fg",
  "<cmd>lua require('jrasmusbm.telescope.find_files').find_files({ hidden=true, no_ignore=true })<cr>",
  { noremap = true }
)
mappings.nmap(
  "<leader>fq",
  "<cmd>lua require('telescope.builtin').quickfix({})<cr>",
  { noremap = true }
)
mappings.nmap(
  "<leader>fl",
  "<cmd>lua require('telescope.builtin').live_grep()<cr>",
  { noremap = true }
)
mappings.nmap(
  "<leader>fb",
  "<cmd>lua require('telescope.builtin').buffers()<cr>",
  { noremap = true }
)
mappings.nmap(
  "<leader>f:",
  "<cmd>lua require('telescope.builtin').command_history()<cr>",
  { noremap = true }
)
mappings.nmap(
  "<leader>f/",
  "<cmd>lua require('telescope.builtin').search_history()<cr>",
  { noremap = true }
)
mappings.nmap(
  "<leader>fh",
  "<cmd>lua require('telescope.builtin').help_tags()<cr>",
  { noremap = true }
)

-- Git search mappings

vim.cmd [[
command! GFiles lua require('jrasmusbm.telescope.git_files').git_files({ show_untracked = true })
]]

mappings.nmap("<localleader>fd", ":VcsJump diff<Space>")
mappings.nmap("<localleader>fg", ":VcsJump grep<Space>")
mappings.nmap("<localleader>fm", ":VcsJump merge<Space>")
mappings.nmap(
  "<localleader>fc",
  "<cmd>lua require('jrasmusbm.telescope.git_commits').git_commits()<cr>"
)
mappings.nmap(
  "<localleader>fi",
  "<cmd>lua require('jrasmusbm.telescope.git_issues').git_issues()<cr>"
)
mappings.nmap(
  "<localleader>fp",
  "<cmd>lua require('jrasmusbm.telescope.git_pull_requests').git_pull_requests()<cr>"
)
mappings.nmap(
  "<localleader>fb",
  "<cmd>lua require('jrasmusbm.telescope.git_branches').git_branches()<cr>"
)
mappings.nmap(
  "<localleader>fs",
  "<cmd>lua require('telescope.builtin').git_status()<cr>"
)

-- Config files
mappings.nmap(
  "<leader>ea",
  "<cmd>lua require('jrasmusbm.telescope.find_files').find_files({ prompt_title = 'All Files', cwd = vim.fn.getenv('DOTFILES') .. '/vim/after/' })<CR>",
  { noremap = true }
)
mappings.nmap(
  "<leader>eu",
  "<cmd>lua require('jrasmusbm.telescope.find_files').find_files({ prompt_title = 'Autoload Files', cwd = vim.fn.getenv('DOTFILES') .. '/vim/autoload/' })<CR>",
  { noremap = true }
)
mappings.nmap(
  "<leader>el",
  "<cmd>lua require('jrasmusbm.telescope.find_files').find_files({ prompt_title = 'Lua Files', cwd = vim.fn.getenv('DOTFILES') .. '/vim/lua/' })<CR>",
  { noremap = true }
)
mappings.nmap(
  "<leader>es",
  "<cmd>lua require('jrasmusbm.telescope.find_files').find_files({ prompt_title = 'Snippet Files', cwd = vim.fn.getenv('DOTFILES') .. '/vim/lua/jrasmusbm/snippets/shared/' })<CR>",
  { noremap = true }
)
mappings.nmap(
  "<leader>eb",
  "<cmd>lua require('jrasmusbm.telescope.find_files').find_files({ prompt_title = 'Filetype Config Files', cwd = vim.fn.getenv('DOTFILES') .. '/bin' })<CR>",
  { noremap = true }
)
mappings.nmap(
  "<leader>ec",
  "<cmd>lua require('jrasmusbm.telescope.find_files').find_files({ prompt_title = 'Zsh Completion Files', cwd = vim.fn.getenv('DOTFILES') .. '/shell/zsh_completions' })<CR>",
  { noremap = true }
)
mappings.nmap(
  "<leader>ei",
  "<cmd>lua require('jrasmusbm.telescope.find_files').find_files({ prompt_title = 'Install Dependencies', cwd = vim.fn.getenv('DOTFILES') .. '/install_dependencies' })<CR>",
  { noremap = true }
)
mappings.nmap(
  "<leader>ef",
  "<cmd>lua require('jrasmusbm.telescope.find_files').find_files({ prompt_title = 'Filetype Config Files', cwd = vim.fn.getenv('DOTFILES') .. '/vim/ftplugin/' })<CR>",
  { noremap = true }
)
mappings.nmap(
  "<leader>ep",
  "<cmd>lua require('jrasmusbm.telescope.find_files').find_files({ prompt_title = 'Plugin Files', cwd = vim.fn.getenv('DOTFILES') .. '/vim/plugin/' })<CR>",
  { noremap = true }
)
mappings.nmap(
  "<leader>et",
  "<cmd>lua require('jrasmusbm.telescope.find_files').find_files({ prompt_title = 'Treesitter Queries', cwd = vim.fn.getenv('DOTFILES') .. '/vim/queries/' })<CR>",
  { noremap = true }
)

vim.keymap.set({ "i" }, "<C-\\><C-I>", function()
  require("jrasmusbm.telescope.git_issues").git_issues()
end, {})

vim.keymap.set({ "i" }, "<C-\\><C-P>", function()
  require("jrasmusbm.telescope.git_pull_requests").git_pull_requests()
end, {})

vim.keymap.set({ "i" }, "<C-\\><C-F>", function()
  require("jrasmusbm.telescope.git_files").git_files { show_untracked = true }
end, {})

vim.keymap.set({ "i" }, "<C-\\><C-H>", function()
  require("telescope.builtin").help_tags()
end, {})

mappings.nmap("<C-O>", "<C-O>zz", { noremap = true })
mappings.nmap("<C-I>", "<C-I>zz", { noremap = true })

mappings.nmap("n", "nzzzv", { noremap = true })
mappings.nmap("N", "Nzzzv", { noremap = true })
mappings.vmap("n", "nzzzv", { noremap = true })
mappings.vmap("N", "Nzzzv", { noremap = true })
