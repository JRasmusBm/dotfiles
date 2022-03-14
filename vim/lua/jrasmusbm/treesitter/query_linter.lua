local M = {}

M.query_linter = {
  enable = true,
  use_virtual_text = true,
  lint_events = { "BufWrite", "CursorHold" },
}

return M
