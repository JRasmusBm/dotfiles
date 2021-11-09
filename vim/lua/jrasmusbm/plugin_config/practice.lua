vim.cmd [[
packadd! vim-hardtime

command! VBG packadd vim-be-good | VimBeGood
]]

vim.g.hardtime_default_on = 0
vim.g.hardtime_maxcount = 1
vim.g.hardtime_timeout = 500
vim.g.hardtime_allow_different_key = 1

mappings.nmap("<leader>ht", "<cmd>HardTimeToggle<CR>", {noremap = true})
