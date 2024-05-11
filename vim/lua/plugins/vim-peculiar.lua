return {
  "JRasmusBm/vim-peculiar",
  lazy = true,
  config = function()
    vim.g["peculiar#suppress_highlight_n"] = 1

    vim.keymap.set({ "n" }, "<localleader>v", "<Plug>PeculiarV")
    vim.keymap.set({ "n" }, "<localleader>g", "<Plug>PeculiarG")
    vim.keymap.set({ "n" }, "<localleader>n", "<Plug>PeculiarN")
    vim.keymap.set({ "n" }, "<localleader>r", "<Plug>PeculiarR")
  end,
  keys = {
    "<localleader>v",
    "<localleader>g",
    "<localleader>n",
    "<localleader>r",
  },
}
