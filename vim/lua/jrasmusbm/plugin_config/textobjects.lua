local mappings = require("jrasmusbm.utils.mappings")

vim.cmd [[
packadd! vim-textobj-between
packadd! vim-textobj-entire
packadd! vim-textobj-line
packadd! vim-textobj-underscore
packadd! vim-textobj-user
packadd! vim-textobj-fold
]]

vim.g.textobj_between_no_default_key_mappings = 0

mappings.omap("ao", "<Plug>(textobj-between-a)")
mappings.vmap("ao", "<Plug>(textobj-between-a)")

mappings.omap("io", "<Plug>(textobj-between-i)")
mappings.vmap("io", "<Plug>(textobj-between-i)")
