return {
  "rcarriga/nvim-notify",
  lazy = true,
  opts = {
    background_colour = "#d4be98",
    fps = 30,
    icons = {
      DEBUG = "",
      ERROR = "",
      INFO = "",
      TRACE = "✎",
      WARN = "",
    },
    level = 1,
    minimum_width = 50,
    render = "default",
    stages = "fade_in_slide_out",
    timeout = 5000,
    top_down = true,
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
}
