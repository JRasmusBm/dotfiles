local filetypes = require("jrasmusbm.filetypes")

vim.cmd [[
packadd! nvim-ts-context-commentstring
packadd! Comment.nvim
]]

require("Comment").setup()

local config = require("Comment.api").get_config()

config["prehook"] = function(context)
  -- Only calculate commentstring for tsx filetypes
  if not vim.tbl_contains(filetypes.tsx, vim.bo.filetype) then return end
  local U = require("Comment.utils")

  local comment_type = {
    [U.ctype.line] = "__default",
    [U.ctype.block] = "__multiline",
  }

  -- Determine the location where to calculate commentstring from
  local location = nil
  if context.ctype == U.ctype.block then
    location = require("ts_context_commentstring.utils").get_cursor_location()
  elseif context.cmotion == U.cmotion.v or context.cmotion == U.cmotion.V then
    location =
      require("ts_context_commentstring.utils").get_visual_start_location()
  end

  return require("ts_context_commentstring.internal").calculate_commentstring({
    key = comment_type[context.ctype],
    location = location,
  })
end
