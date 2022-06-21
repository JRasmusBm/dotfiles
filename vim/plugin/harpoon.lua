local mappings = require "jrasmusbm.utils.mappings"

vim.cmd [[
packadd harpoon
]]

mappings.nmap(
  "<leader>mf",
  ':lua require("harpoon.mark").add_file()<CR>',
  { noremap = true }
)
mappings.nmap(
  "<leader>mm",
  ':lua require("harpoon.ui").toggle_quick_menu()<CR>',
  { noremap = true }
)
mappings.nmap(
  "<leader>1",
  ':lua require("harpoon.ui").nav_file(1)<CR>',
  { noremap = true }
)
mappings.nmap(
  "<leader>2",
  ':lua require("harpoon.ui").nav_file(2)<CR>',
  { noremap = true }
)
mappings.nmap(
  "<leader>3",
  ':lua require("harpoon.ui").nav_file(3)<CR>',
  { noremap = true }
)
mappings.nmap(
  "<leader>4",
  ':lua require("harpoon.ui").nav_file(4)<CR>',
  { noremap = true }
)
mappings.nmap(
  "<leader>5",
  ':lua require("harpoon.ui").nav_file(5)<CR>',
  { noremap = true }
)
mappings.nmap(
  "<leader>6",
  ':lua require("harpoon.ui").nav_file(6)<CR>',
  { noremap = true }
)
mappings.nmap(
  "<leader>7",
  ':lua require("harpoon.ui").nav_file(7)<CR>',
  { noremap = true }
)
mappings.nmap(
  "<leader>8",
  ':lua require("harpoon.ui").nav_file(8)<CR>',
  { noremap = true }
)
mappings.nmap(
  "<leader>9",
  ':lua require("harpoon.ui").nav_file(9)<CR>',
  { noremap = true }
)
mappings.nmap(
  "<leader>0",
  ':lua require("harpoon.ui").nav_file(10)<CR>',
  { noremap = true }
)
