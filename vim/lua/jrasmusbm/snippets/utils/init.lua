local M = {}

local utils = require "telescope.utils"
local ls = require "luasnip"
local sn = ls.snippet_node
local d = ls.dynamic_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local t = ls.text_node

M.line_number = function(_, _)
  return sn(0, { t(tostring(vim.fn.line ".")) })
end

M.file_path = function(_, _)
  return sn(0, { t(vim.fn.expand "%") })
end

M.date = function(_, _)
  return sn(0, { t(os.date "%Y-%m-%d") })
end

M.time = function(_, _)
  return sn(0, { t(os.date "%H:%M") })
end

M.file_name = function(_, _)
  return sn(0, { t(vim.fn.expand "%:p:h") })
end

M.basename = function(_, _)
  local path = vim.api.nvim_buf_get_name(0)
  local path_segments = vim.split(path, "/")
  local filename = path_segments[#path_segments]
  local basename = vim.split(filename, "%.")[1]
  return sn(0, { t(basename) })
end

M.capitalize = function(pos, pos_to_capitalize)
  return d(pos, function(args)
    return sn(1, { t((args[1][1]:gsub("^%l", string.upper))) })
  end, { pos_to_capitalize }, {})
end

M.load_shared = function(options)
  local module_name = "jrasmusbm.snippets.shared." .. options.shared

  require("plenary.reload").reload_module(module_name)

  local snippets = {}

  for _, snippet in pairs(require(module_name)) do
    table.insert(snippets, snippet())
  end

  ls.add_snippets(options.filetype, snippets)
end

M.fill_command = function(cmd)
  return fmt(
    [[
{}
]],
    {
      f(function(_args, _parent, cmd)
        return utils.get_os_command_output(cmd)
      end, {}, { user_args = { cmd } }),
    }
  )
end

return M
