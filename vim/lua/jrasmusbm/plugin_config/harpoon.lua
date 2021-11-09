vim.cmd [[
packadd! harpoon

nnoremap <leader>mf :lua require("harpoon.mark").add_file()<CR>
nnoremap <leader>mm :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <leader>m1 :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <leader>m2 :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <leader>m3 :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <leader>m4 :lua require("harpoon.ui").nav_file(4)<CR>
nnoremap <leader>m5 :lua require("harpoon.ui").nav_file(5)<CR>
nnoremap <leader>m6 :lua require("harpoon.ui").nav_file(6)<CR>
nnoremap <leader>m7 :lua require("harpoon.ui").nav_file(7)<CR>
nnoremap <leader>m8 :lua require("harpoon.ui").nav_file(8)<CR>
nnoremap <leader>m9 :lua require("harpoon.ui").nav_file(9)<CR>
nnoremap <leader>m0 :lua require("harpoon.ui").nav_file(10)<CR>
]]
