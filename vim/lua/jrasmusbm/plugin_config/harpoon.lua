local mappings = require "jrasmusbm.utils.mappings"

vim.cmd [[
packadd! harpoon
]]

mappings.nmap("<leader>mf", ':lua require("harpoon.mark").add_file()<CR>', { noremap = true })
mappings.nmap("<leader>mm", ':lua require("harpoon.ui").toggle_quick_menu()<CR>', { noremap = true })
mappings.nmap("<leader>m1", ':lua require("harpoon.ui").nav_file(1)<CR>', { noremap = true })
mappings.nmap("<leader>m2", ':lua require("harpoon.ui").nav_file(2)<CR>', { noremap = true })
mappings.nmap("<leader>m3", ':lua require("harpoon.ui").nav_file(3)<CR>', { noremap = true })
mappings.nmap("<leader>m4", ':lua require("harpoon.ui").nav_file(4)<CR>', { noremap = true })
mappings.nmap("<leader>m5", ':lua require("harpoon.ui").nav_file(5)<CR>', { noremap = true })
mappings.nmap("<leader>m6", ':lua require("harpoon.ui").nav_file(6)<CR>', { noremap = true })
mappings.nmap("<leader>m7", ':lua require("harpoon.ui").nav_file(7)<CR>', { noremap = true })
mappings.nmap("<leader>m8", ':lua require("harpoon.ui").nav_file(8)<CR>', { noremap = true })
mappings.nmap("<leader>m9", ':lua require("harpoon.ui").nav_file(9)<CR>', { noremap = true })
mappings.nmap("<leader>m0", ':lua require("harpoon.ui").nav_file(10)<CR>', { noremap = true })
