vim.cmd [[
imap ;f =expand("%:")<Left><Left>
cmap ;f =expand("%:")<Left><Left>
]]

vim.keymap.set({ "i", "s" }, "<leader>s", function()
  local edit_utils = require "jrasmusbm.utils.edit"
  local ls = require "luasnip"
  if ls.expandable() then
    ls.expand()
    edit_utils.feedkeys("<esc>a", "i")
    edit_utils.add_undo_breakpoint()
  end
end, { silent = true })

vim.keymap.set({ "n" }, "<leader>s", function()
  local edit_utils = require "jrasmusbm.utils.edit"
  local ls = require "luasnip"
  if ls.expandable() then
    edit_utils.add_undo_breakpoint()
    ls.expand()
    edit_utils.feedkeys("<esc>a", "i")
  end
end, { silent = true })

vim.keymap.set({ "i", "s", "n" }, "<leader>S", function()
  local ls = require "luasnip"
  ls.unlink_current()
end, { silent = true })

vim.keymap.set({ "i", "n" }, "<leader>g", function()
  local edit_utils = require "jrasmusbm.utils.edit"
  local ls = require "luasnip"
  if ls.jumpable(1) then
    edit_utils.add_undo_breakpoint()
    ls.jump(1)
    edit_utils.feedkeys("<esc>a", "i")
  else
    pcall(vim.fn["bushels#forward_marker"], 1)
  end
end, { silent = true })

vim.keymap.set({ "i", "n" }, "<leader>G", function()
  local edit_utils = require "jrasmusbm.utils.edit"
  if ls.jumpable(-1) then
    edit_utils.add_undo_breakpoint()
    ls.jump(-1)
    edit_utils.feedkeys("<esc>a", "i")
  else
    pcall(vim.fn["bushels#backward_marker"], 1)
  end
end, { silent = true })

vim.keymap.set({ "i" }, "<leader><leader>", "<++>")
