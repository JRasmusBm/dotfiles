local M = {}

M.extract_node_name = function(node)
  local sexpr = node:sexpr()
  return vim.split(sexpr, "[ ()]")[2]
end

M.find_first_parent_by_names = function(names, node, silent)
  local current_node = node

  while true do
    if current_node == nil then
      return nil
    end

    for _, name in ipairs(names) do
      if M.extract_node_name(current_node) == name then
        if silent ~= true then
          print("Found parent " .. name)
        end
        return current_node
      end
      if silent ~= true then
        print "Skipped parent"
      end
    end

    current_node = current_node:parent()
  end
end

M.find_child_by_name = function(node, child_name, silent)
  for child, field_name in node:iter_children() do
    if field_name == child_name then
      if silent ~= true then
        print("Found field " .. child_name)
      end

      return child
    end

    if M.extract_node_name(child) == child_name then
      if silent ~= true then
        print("Found child " .. child_name)
      end

      return child
    end
  end

  print("Could not find child/field " .. child_name)
  return nil
end

M.lookup_children_paths = function(node, children_lookup_path_list, silent)
  local current_node = node

  for _, child_path in ipairs(children_lookup_path_list) do
    current_node = node

    for _, lookup_value in ipairs(child_path) do
      if type(lookup_value) == "number" then
        current_node = current_node:child(lookup_value)
        print(
          "Found child "
            .. M.extract_node_name(current_node)
            .. " at index "
            .. lookup_value
            .. "."
        )
      else
        current_node = M.find_child_by_name(current_node, lookup_value, silent)
      end
    end
  end

  return current_node
end

M.up_and_down = function(path_pairs, silent)
  for _, pair in ipairs(path_pairs) do
    local parent =
      M.find_first_parent_by_names(pair[1], vim.treesitter.get_node(), silent)
    if parent ~= nil then
      local child = M.lookup_children_paths(parent, pair[2], silent)

      if child ~= nil then
        return child
      end
    end

    if silent ~= true then
      print "Skipping pair!"
      print(vim.inspect {
        pair = pair,
      })
    end
  end

  return nil
end

return M
