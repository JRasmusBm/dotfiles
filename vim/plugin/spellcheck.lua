vim.api.nvim_create_user_command("LEn", function()
  vim.bo.spelllang = "en_us"
end, { nargs = "*" })

vim.api.nvim_create_user_command("LSv", function()
  vim.bo.spelllang = "sv"
end, { nargs = "*" })

vim.api.nvim_create_user_command("LDe", function()
  vim.bo.spelllang = "de"
end, { nargs = "*" })

vim.api.nvim_create_user_command("LNl", function()
  vim.bo.spelllang = "nl"
end, { nargs = "*" })

vim.api.nvim_create_user_command("LCl", function()
  vim.bo.spelllang= ""
end, { nargs = "*" })

vim.api.nvim_create_user_command("LTog", function()
  vim.bo.spell = not vim.bo.spell
end, { nargs = "*" })

