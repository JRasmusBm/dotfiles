local M = {}

M.ensure_setup = function()
  if not require("jrasmusbm.utils").ensure_setup "vim-polyglot" then
    return
  end

  vim.g.vim_markdown_frontmatter = 1
end

return M
