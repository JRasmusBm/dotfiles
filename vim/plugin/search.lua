local mappings = require "jrasmusbm.utils.mappings"

mappings.nmap("<C-O>", "<C-O>zz", { noremap = true })
mappings.nmap("<C-I>", "<C-I>zz", { noremap = true })

mappings.nmap("n", "nzzzv", { noremap = true })
mappings.nmap("N", "Nzzzv", { noremap = true })
mappings.vmap("n", "nzzzv", { noremap = true })
mappings.vmap("N", "Nzzzv", { noremap = true })
