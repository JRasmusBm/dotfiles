vim.cmd [[
highlight NotifyBackground guifg=#32302f guibg=#32302f

packadd! nvim-notify
]]

require("notify").setup({
  stages = "fade",
  timeout = 3000,
  background_colour = "NotifyBackground",
  icons = {
    ERROR = "",
    WARN = "",
    INFO = "",
    DEBUG = "",
    TRACE = "✎",
  },
})
