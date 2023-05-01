local M = {}

local find_first_parent_by_names = function(names, node)
  local current_node = node or vim.treesitter.get_node()

  while true do
    if not current_node then
      return nil
    end

    for _, name in ipairs(names) do
      local matcher = "^%(" .. name
      local sexpr = current_node:sexpr()

      if string.match(sexpr, matcher) then
        return current_node
      end
    end

    current_node = current_node:parent()
  end
end

local lookup_children_paths = function(node, children_lookup_path_list)
  for _, child_path in ipairs(children_lookup_path_list) do
    local current_node = node
    for _, child_name in ipairs(child_path) do
      if current_node == nil then
        break
      end

      current_node = node:field(child_name)[1]
        or current_node:child(child_name)
        or current_node:named_child(child_name)
    end

    if current_node ~= nil then
      return current_node
    end
  end

  return nil
end

M.setup_parent_mappings = function(parent_names, children_paths)
  vim.keymap.set({ "n" }, "<leader>ao", function()
    local parent = find_first_parent_by_names(parent_names)

    if parent == nil then
      print "Parent not found"
      return
    end

    local name_node = lookup_children_paths(parent, children_paths)

    if name_node == nil then
      print "Child not found"
      return
    end

    local row, column = name_node:start()
    vim.api.nvim_win_set_cursor(0, { row + 1, column })
  end, {})
end

return M
