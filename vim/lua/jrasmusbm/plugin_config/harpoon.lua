vim.cmd [[
packadd! harpoon

nnoremap <leader>mf :lua require("harpoon.mark").add_file()
nnoremap <leader>mm :lua require("harpoon.ui").toggle_quick_menu()
nnoremap <leader>m1 :lua require("harpoon.ui").nav_file(1)
nnoremap <leader>m2 :lua require("harpoon.ui").nav_file(2)
nnoremap <leader>m3 :lua require("harpoon.ui").nav_file(3)
nnoremap <leader>m4 :lua require("harpoon.ui").nav_file(4)
nnoremap <leader>m5 :lua require("harpoon.ui").nav_file(5)
nnoremap <leader>m6 :lua require("harpoon.ui").nav_file(6)
nnoremap <leader>m7 :lua require("harpoon.ui").nav_file(7)
nnoremap <leader>m8 :lua require("harpoon.ui").nav_file(8)
nnoremap <leader>m9 :lua require("harpoon.ui").nav_file(9)
nnoremap <leader>m0 :lua require("harpoon.ui").nav_file(10)
]]
