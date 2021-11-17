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
