local M = {}

local utils = require("jrasmusbm.utils")

local highlights = {
  default = {"StatusLineDefault", {fg = "fg0", bg = "bg1"}},
  git_branch = {"StatusLineGitBranch", {fg = "lightgreen", bg = "bg1"}},
  modified = {"StatusLineModified", {fg = "orange", bg = "bg1"}},
}

local function hl_identifier(group) return "%#" .. group .. "#" end

M.setup =
  function() require("jrasmusbm.highlights").set_highlights(highlights) end

local function diagnostic_count(options)
  local count = vim.diagnostic.get(0, {severity = options.severity})

  if #count == 0 then return "" end

  return #count .. utils.space(1) .. options.symbol .. utils.space(2)
end

local function cursor_position()
  local cursor = vim.fn.getcurpos()
  return cursor[2] .. " ↑   " .. cursor[3] .. " → "
end

local function file_type() return "[" .. vim.bo.filetype .. "]" end

local function git_branch()
  local head = vim.fn["fugitive#head"]()
  if not head or head == "" then return "" end
  return "⎇  " .. head
end

local function modified_flag() return "%m" end

local function item_group(options)
  local hl_start = (options.highlight ~= nil and
                     hl_identifier((options.highlight or highlights.default)[1])) or
                     ""
  local hl_end = (options.highlight ~= nil and
                   hl_identifier(highlights.default[1])) or ""
  return
    "" .. hl_start .. "%-" .. options.min_size .. "." .. options.max_size .. "(" ..
      options.value .. "%)" .. hl_end
end

local even_split = "%="

M.activeStatusLine = function()
  return "" .. item_group {
    value = git_branch(),
    min_size = 0,
    max_size = 20,
    highlight = highlights.git_branch,
  } .. utils.space(1) ..
           item_group {value = file_type(), min_size = 0, max_size = 20} ..
           utils.space(1) ..
           item_group {value = vim.fn.bufname("%"), min_size = 0, max_size = 60} ..
           utils.space(1) .. item_group {
    value = modified_flag(),
    min_size = 4,
    max_size = 4,
    highlight = highlights.modified,
  } .. even_split .. item_group {
    value = diagnostic_count {
      severity = vim.diagnostic.severity.ERROR,
      symbol = "✗",
    },
    min_size = 0,
    max_size = 8,
    highlight = {"DiagnosticSignError"},
  } .. item_group {
    value = diagnostic_count {
      severity = vim.diagnostic.severity.WARN,
      symbol = "⚠",
    },
    min_size = 0,
    max_size = 8,
    highlight = {"DiagnosticSignWarning"},
  } .. item_group {
    value = diagnostic_count {
      severity = vim.diagnostic.severity.INFO,
      symbol = "i",
    },
    min_size = 0,
    max_size = 8,
    highlight = {"DiagnosticSignInformation"},
  } .. item_group {
    value = diagnostic_count {
      severity = vim.diagnostic.severity.HINT,
      symbol = "☼",
    },
    min_size = 0,
    max_size = 8,
    highlight = {"DiagnosticSignHint"},
  } .. item_group {value = vim.fn.VpmStatusline(), min_size = 0, max_size = 20} ..
           utils.space(1) ..
           item_group {value = cursor_position(), min_size = 4, max_size = 20}
end

M.inactiveStatusLine = function()
  return "" .. item_group {value = git_branch(), min_size = 0, max_size = 20} ..
           utils.space(1) ..
           item_group {value = file_type(), min_size = 0, max_size = 20} ..
           utils.space(1) ..
           item_group {value = vim.fn.bufname("%"), min_size = 0, max_size = 60} ..
           utils.space(1) ..
           item_group {value = modified_flag(), min_size = 4, max_size = 4} ..
           even_split .. item_group {
    value = diagnostic_count {
      severity = vim.diagnostic.severity.ERROR,
      symbol = "✗",
    },
    min_size = 0,
    max_size = 8,
  } .. item_group {
    value = diagnostic_count {
      severity = vim.diagnostic.severity.WARN,
      symbol = "⚠",
    },
    min_size = 0,
    max_size = 8,
  } .. item_group {
    value = diagnostic_count {
      severity = vim.diagnostic.severity.INFO,
      symbol = "i",
    },
    min_size = 0,
    max_size = 8,
  } .. item_group {
    value = diagnostic_count {
      severity = vim.diagnostic.severity.HINT,
      symbol = "☼",
    },
    min_size = 0,
    max_size = 8,
  } .. item_group {value = vim.fn.VpmStatusline(), min_size = 0, max_size = 20} ..
           utils.space(11)
end

return M
