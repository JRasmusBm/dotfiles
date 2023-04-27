vim.g.name = "Rasmus Bergström"

vim.opt.background = require("jrasmusbm.theme").get_current_theme()
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.encoding = "utf-8"
vim.opt.swapfile = false
vim.opt.fileformat = "unix"
vim.opt.hidden = true
vim.opt.modelines = 0
vim.opt.viewoptions = { "cursor", "folds", "slash", "unix" }
vim.opt.hlsearch = true
vim.opt.shortmess = "F"
vim.opt.cmdheight = 1
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.splitbelow = true
