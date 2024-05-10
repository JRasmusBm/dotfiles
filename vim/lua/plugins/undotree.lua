return {
  "mbbill/undotree",
  lazy = true,
  config = function()
    vim.opt.undodir = vim.fn.stdpath "data" .. "/undodir"
    vim.opt.undofile = true
  end,
  cmd = {
    "UndotreeToggle",
  },
}
