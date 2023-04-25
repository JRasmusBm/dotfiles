vim.opt.undodir = vim.fn.stdpath "data" .. "/undodir"
vim.opt.undofile = true

vim.api.nvim_create_user_command("UndotreeToggle", function(options)
  require("jrasmusbm.utils").ensure_setup "undotree"

  require("jrasmusbm.utils.commands").run("UndotreeToggle", options)
end, { nargs = "*" })
