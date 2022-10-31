local mappings = require "jrasmusbm.utils.mappings"

require("jrasmusbm.utils").ensure_setup("vim-presentation-mode")

mappings.nmap("<leader>vc", "<cmd>VpmOff<cr>", { noremap = true })
mappings.nmap("<leader>vn", "<cmd>VpmNextHighlight<cr>", { noremap = true })
mappings.nmap("<leader>vp", "<cmd>VpmPreviousHighlight<cr>", { noremap = true })
mappings.nmap("<leader>vf", "<cmd>VpmOpenNextFile<cr>", { noremap = true })

vim.g.vpm_highlight_color = "gray"
