local mappings = require "jrasmusbm.utils.mappings"

vim.keymap.set({ "n" }, "<leader>fi", function ()
  require("jrasmusbm.utils").ensure_setup("vim-enmasse")

  vim.cmd[[ EnMasse ]]
end
, { noremap=true })
