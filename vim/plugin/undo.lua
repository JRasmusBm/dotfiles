vim.opt.undodir = vim.fn.stdpath "data" .. "/undodir"
vim.opt.undofile = true

local handler = function(options)
  require("jrasmusbm.utils").ensure_setup "undotree"

  require("jrasmusbm.utils.commands").run("UndotreeToggle", options)
end

vim.api.nvim_create_user_command("Undo", handler, { nargs = "*" })
vim.api.nvim_create_user_command("Un", handler, { nargs = "*" })
