vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.showcmd = true
vim.opt.emoji = false
vim.opt.list = true
vim.opt.listchars = { tab = "▷ ", trail = "·" }
vim.opt.signcolumn = "auto"
vim.opt.ruler = true
vim.opt.laststatus = 2
vim.opt.cmdheight = 2
vim.opt.wrap = true
vim.opt.textwidth = 79
vim.opt.colorcolumn = "+1"
vim.opt.scrolloff = 8
vim.opt.tabstop = 2
vim.opt.guicursor = require("jrasmusbm.utils.options").list {
  "n-v-c-sm:block",
  "i-ci-ve:ver25",
  "r-cr-o:hor20",
}

vim.cmd [[
autocmd VimResized * :wincmd =

highlight! Normal ctermbg=NONE guibg=NONE
highlight! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
]]

vim.keymap.set({ "n" },
  "<silent><Leader>ww",
  ":syntax sync fromstart<CR>",
  { noremap = true }
)
