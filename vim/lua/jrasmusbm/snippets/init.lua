vim.cmd [[
packadd! LuaSnip
packadd! vim-bushels
]]

local ls = require("luasnip")

vim.keymap.set({"i", "s", "n"}, "<leader>s",
               function() if ls.expandable() then ls.expand() end end,
               {silent = true})

vim.keymap.set({"i", "s", "n"}, "<leader>S", ls.unlink_current, {silent = true})

vim.keymap.set({"i", "n"}, "<leader>g", function()
  if ls.jumpable(1) then
    ls.jump(1)
  else
    pcall(vim.fn["bushels#forward_marker"], 1)
  end
end, {silent = true})

vim.keymap.set({"i", "n"}, "<leader>G", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  else
    pcall(vim.fn["bushels#backward_marker"], 1)
  end
end, {silent = true})

vim.keymap.set({"i"}, "<leader><leader>", "<++>")

ls.config.set_config {history = true, updateevents = "TextChanged,TextChangedI"}

ls.filetype_extend("tsx", {"html", "css"})
ls.filetype_extend("jsx", {"html", "css"})
ls.filetype_extend("typescript", {"graphql"})
ls.filetype_extend("graphql", {"javascript"})
