require("jrasmusbm.utils").ensure_setup "nvim-notify"
require("notify").setup {
  background_colour = "#d4be98",
  fps = 30,
  icons = {
    DEBUG = "",
    ERROR = "",
    INFO = "",
    TRACE = "✎",
    WARN = "",
  },
  level = 2,
  minimum_width = 50,
  render = "default",
  stages = "fade_in_slide_out",
  timeout = 5000,
  top_down = true,
}

vim.keymap.set({ "n" }, "<leader><esc>", function()
  require("notify").dismiss()
end, {})

vim.api.nvim_create_user_command("Messages", function()
  require("jrasmusbm.telescope").ensure_setup()

  vim.cmd.Noice()
end, { nargs = "*" })

vim.keymap.set({ "n" }, "<leader>fm", function()
  require("jrasmusbm.telescope").ensure_setup()

  require("telescope").extensions.notify.notify()
end, {})
