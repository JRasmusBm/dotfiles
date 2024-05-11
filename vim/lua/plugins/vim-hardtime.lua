return {
  "takac/vim-hardtime",
  lazy = true,
  config = function()
    vim.g.hardtime_default_on = 1
    vim.g.hardtime_maxcount = 1
    vim.g.hardtime_timeout = 500
    vim.g.hardtime_allow_different_key = 1
  end,
  cmd = { "HardTimeToggle" },
}
