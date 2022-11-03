function with_vpm(map, command)
require("jrasmusbm.utils").ensure_setup("vim-presentation-mode")
  
vim.keymap.set({ "n" },map, "<cmd>" .. command .. "<cr>", { noremap = true })
end

with_vpm("<leader>vc", "<cmd>VpmOff<cr>")
with_vpm("<leader>vn", "<cmd>VpmNextHighlight<cr>")
with_vpm("<leader>vp", "<cmd>VpmPreviousHighlight<cr>")
with_vpm("<leader>vf", "<cmd>VpmOpenNextFile<cr>")

vim.g.vpm_highlight_color = "gray"
