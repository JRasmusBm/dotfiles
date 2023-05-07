local M = {}

M.main = function()
  local queries = require "nvim-treesitter.query"
  local matches = queries.get_capture_matches(0, "@function.name", "functions")
  if matches == nil or #matches == 0 then
    print "No matches found"
    return
  end

  local nodes = {}
  for _, match in ipairs(matches) do
    nodes[string.lower(vim.treesitter.get_node_text(match.node, 0))] =
      match.node
  end

  local path = vim.api.nvim_buf_get_name(0)
  local path_segments = vim.split(path, "/")
  local filename = path_segments[#path_segments]
  local basename = vim.split(filename, "%.")[1]

  local possible_names = {
    "main",
    basename,
    string.gsub(basename, "-", ""),
    string.gsub(basename, "-", "_"),
  }

  local result = nil
  for _, name in ipairs(possible_names) do
    local node = nodes[string.lower(name)]
    if node ~= nil then
      result = node
      break
    end
  end

  if result == nil then
    print "No main node found"
    return
  end

  local row, column = result:start()

  vim.cmd.normal "m`"
  vim.api.nvim_win_set_cursor(0, { row + 1, column })
end

return M
