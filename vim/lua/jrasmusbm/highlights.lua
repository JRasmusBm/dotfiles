local M = {}

M.set_highlight = function(group, options)
  local bg = options.bg == nil and '' or 'guibg=' .. options.bg
  local fg = options.fg == nil and '' or 'guifg=' .. options.fg
  local gui = options.gui == nil and '' or 'gui=' .. options.gui

  local command = string.format('hi %s %s %s %s', group, bg, fg, gui)

  -- vim.fn["gruvbox_material#highlight"](group, options.fg, options.bg)
  vim.api.nvim_exec(command, false)
end

M.set_highlights = function (highlights)
  for _, highlight in pairs(highlights) do
    M.set_highlight(highlight[1], highlight[2])
  end
end

return M
