vim.cmd [[
packadd! LuaSnip
]]

local ls = require("luasnip")

vim.keymap.set({"i", "s", "n"}, "<leader>s", function()
  if ls.expand_or_jumpable() then ls.expand_or_jump() end
end, {silent = true})

ls.config.set_config {history = true, updateevents = "TextChanged,TextChangedI"}
