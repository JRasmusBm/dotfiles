vim.keymap.set({ "n" }, "ys", function()
  require("jrasmusbm.utils").ensure_setup "vim-surround"

  require("jrasmusbm.utils.edit").feedkeys "ys"
end
, {})

vim.keymap.set({ "n" }, "ds", function()
  require("jrasmusbm.utils").ensure_setup "vim-surround"

  require("jrasmusbm.utils.edit").feedkeys "ds"
end
, {})

vim.keymap.set({ "n" }, "cs", function()
  require("jrasmusbm.utils").ensure_setup "vim-surround"

  require("jrasmusbm.utils.edit").feedkeys "cs"
end
, {})

vim.keymap.set({ "n" }, "yS", function()
  require("jrasmusbm.utils").ensure_setup "vim-surround"

  require("jrasmusbm.utils.edit").feedkeys "yS"
end
, {})

vim.keymap.set({ "n" }, "ySS", function()
  require("jrasmusbm.utils").ensure_setup "vim-surround"

  require("jrasmusbm.utils.edit").feedkeys "ySS"
end
, {})
