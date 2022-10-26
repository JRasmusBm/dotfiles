vim.keymap.set({ "n", "o" }, "az", function()
  vim.keymap.del({ "n", "o" }, "az")

  require("jrasmusbm.utils").ensure_setup "vim-textobj-user"
  require("jrasmusbm.utils").ensure_setup "vim-textobj-fold"

  require("jrasmusbm.utils.mappings").feedkeys "<Plug>(textobj-fold-a)"
end, {})

vim.keymap.set({ "n", "o" }, "iz", function()
  vim.keymap.del({ "n", "o" }, "iz")

  require("jrasmusbm.utils").ensure_setup "vim-textobj-user"
  require("jrasmusbm.utils").ensure_setup "vim-textobj-fold"

  require("jrasmusbm.utils.mappings").feedkeys "<Plug>(textobj-fold-i)"
end, {})
