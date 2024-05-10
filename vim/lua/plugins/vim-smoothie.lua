return {
  "psliwka/vim-smoothie",
  lazy = true,
  config = function()
    vim.g.smoothie_update_interval = 20
    vim.g.smoothie_speed_constant_factor = 20
    vim.g.smoothie_speed_linear_factor = 20
    vim.g.smoothie_speed_exponentiation_factor = 0.95
  end,
  key = {
    "<C-d>",
    "<C-u>",
  },
}
