return {
  "christoomey/vim-presentation-mode",
  lazy = true,
  config = function()
    vim.g.vpm_highlight_color = "gray"

    vim.keymap.set({ "n" }, "<leader>vc", "<cmd>VpmOff<cr>")
    vim.keymap.set({ "n" }, "<leader>vn", "<cmd>VpmNextHighlight<cr>")
    vim.keymap.set({ "n" }, "<leader>vp", "<cmd>VpmPreviousHighlight<cr>")
    vim.keymap.set({ "n" }, "<leader>vf", "<cmd>VpmOpenNextFile<cr>")
  end,
  keys = {
    "<leader>vc",
    "<leader>vn",
    "<leader>vp",
    "<leader>vf",
  },
}
