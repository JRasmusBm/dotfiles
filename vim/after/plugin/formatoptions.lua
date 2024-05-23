vim.opt.formatoptions = require("jrasmusbm.utils.options").list({
  "c", -- Add comments when using enter in insert mode
  "r", -- Wrap comments at textwidth
  "q", -- Allow using gq on comments
  "n", -- Recognize numbered lists
  "1", -- Break line before one letter words, not after
  "j", -- Remove comment when joining lines
}, "", "")
