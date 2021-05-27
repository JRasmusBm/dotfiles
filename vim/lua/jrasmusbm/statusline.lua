local M = {}

local function lsp_status()
  local warnings = vim.lsp.diagnostic.get_count(0, "Warning")
  local errors = vim.lsp.diagnostic.get_count(0, "Error")
  local info = vim.lsp.diagnostic.get_count(0, "Info")
  local hints = vim.lsp.diagnostic.get_count(0, "Hint")

  local result = ""

  if errors ~= 0 then
    result = result .. errors .. " ✗  "
  end

  if warnings ~= 0 then
    result = result .. warnings .. " ⚠  "
  end

  if info ~= 0 then
    result = result .. info .. " i  "
  end

  if hints ~= 0 then
    result = result .. hints .. " ☼  "
  end

  return result
end

local function cursor_position()
  local cursor = vim.fn.getcurpos()
  return cursor[2] .. " ↑   " .. cursor[3] .. " → "
end

local function file_type()
  return "[" .. vim.bo.filetype .. "]"
end

local function git_branch()
  local head = vim.fn["fugitive#head"]()
  if not head or head == "" then
      return ""
  end
  return "⎇  " .. head
end

local function modified_flag()
  return "%m"
end

local function item_group(options)
  return "%-" .. options.min_size .. "." .. options.max_size .. "(" .. options.value .. "%)"
end

local function space(n)
  return string.rep(" ", n)
end

local even_split =  "%="

M.activeStatusLine = function ()
  return ""
    .. item_group{ value=git_branch(), min_size=0, max_size=20 }
    .. space(1)
    .. item_group{ value=file_type(), min_size=0, max_size=20 }
    .. space(1)
    .. item_group{ value=vim.fn.bufname("%"), min_size=0, max_size=60 }
    .. space(1)
    .. item_group{ value=modified_flag(), min_size=4, max_size=4 }
    .. even_split
    .. item_group{ value=lsp_status(), min_size=10, max_size=10 }
    .. item_group{ value=cursor_position(), min_size=4, max_size=20 }
end

M.inactiveStatusLine = function ()
  return ""
    .. item_group{ value=git_branch(), min_size=0, max_size=20 }
    .. space(1)
    .. item_group{ value=file_type(), min_size=0, max_size=20 }
    .. space(1)
    .. item_group{ value=vim.fn.bufname("%"), min_size=0, max_size=60 }
    .. space(1)
    .. item_group{ value=modified_flag(), min_size=4, max_size=4 }
    .. even_split
    .. item_group{ value=lsp_status(), min_size=10, max_size=10 }
    .. space(10)
end

return M
