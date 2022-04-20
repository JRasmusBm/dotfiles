local mappings = require "jrasmusbm.utils.mappings"

vim.opt.splitright = true

mappings.nmap("<leader>bd", "<cmd>bp! <BAR> bd #<CR>", {})

mappings.nmap("c<C-j>", "<cmd>bel sp %<cr>", { noremap = true })
mappings.nmap("c<C-k>", "<cmd>abo sp %<cr>", { noremap = true })
mappings.nmap("c<C-h>", "<cmd>lefta vsp %<cr>", { noremap = true })
mappings.nmap("c<C-l>", "<cmd>rightb vsp %<cr>", { noremap = true })
mappings.nmap("d<C-j>", "<C-w>j<C-w>c", { noremap = true })
mappings.nmap("d<C-k>", "<C-w>k<C-w>c", { noremap = true })
mappings.nmap("d<C-h>", "<C-w>h<C-w>c", { noremap = true })
mappings.nmap("d<C-l>", "<C-w>l<C-w>c", { noremap = true })
mappings.nmap("o<C-j>", "<cmd>bel sp %<cr><C-w>j<C-w>c", { noremap = true })
mappings.nmap("o<C-k>", "<cmd>abo sp %<cr><C-w>k<C-w>c", { noremap = true })
mappings.nmap("o<C-h>", "<cmd>lefta vsp %<cr><C-w>h<C-w>c", { noremap = true })
mappings.nmap("o<C-l>", "<cmd>rightb vsp %<cr><C-w>l<C-w>c", { noremap = true })
