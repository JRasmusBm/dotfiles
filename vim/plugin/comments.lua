vim.keymap.set({ "n", "v" }, "gc", function()
  require("jrasmusbm.comments").ensure_setup()

  require("jrasmusbm.utils.mappings").feedkeys "gc"
end, {})

vim.keymap.set({ "n" }, "gcc", function()
  require("jrasmusbm.comments").ensure_setup()

  require("jrasmusbm.utils.mappings").feedkeys "gcc"
end, {})
