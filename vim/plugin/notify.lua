require("jrasmusbm.utils").ensure_setup "nvim-notify"
require("notify").setup {
  background_colour = "#d4be98",
}

vim.api.nvim_create_user_command("Messages", function()
  require("jrasmusbm.telescope").ensure_setup()

  vim.cmd.Noice()
end, { nargs = "*" })

vim.keymap.set({ "n" }, "<leader>fm", function()
  require("jrasmusbm.telescope").ensure_setup()

  require("telescope").extensions.notify.notify()
end, {})

