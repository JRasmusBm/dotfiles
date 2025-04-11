vim.keymap.set({ "n" }, ";od", function()
  vim.system { "open", vim.fn.expand "%:p:h" }
end
, {})
