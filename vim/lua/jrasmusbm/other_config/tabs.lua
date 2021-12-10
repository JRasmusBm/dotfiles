local mappings = require("jrasmusbm.utils.mappings")

mappings.nmap("]t", "<cmd>tabn", {noremap = true})
mappings.nmap("[t", "<cmd>tabp", {noremap = true})
mappings.nmap("<leader>to", "<cmd>exec \"tabe \" . @%<cr>", {noremap = true})
mappings.nmap("<leader>tc", "<cmd>tabc<cr>", {noremap = true})
