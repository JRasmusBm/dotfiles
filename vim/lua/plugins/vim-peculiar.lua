return {
  "JRasmusBm/vim-peculiar",
  lazy = true,
  config = function()
    vim.g["peculiar#suppress_highlight_n"] = 1
  end,
  keys = {
    "<localleader>v",
    "<localleader>g",
    "<localleader>n",
    "<localleader>r",
  },
}
