local M = {}

M.setup_parent_mappings = function(parent_names, children_paths)
  vim.keymap.set({ "n" }, "<leader>ao", function()
    local parent =
      require("jrasmusbm.treesitter.utils").find_first_parent_by_names(
        parent_names,
        vim.treesitter.get_node()
      )

    if parent == nil then
      print "Parent not found"
      return
    end

    local name_node =
      require("jrasmusbm.treesitter.utils").lookup_children_paths(
        parent,
        children_paths
      )

    if name_node == nil then
      print "Child not found"
      return
    end

    local row, column = name_node:start()

    vim.cmd.normal "m`"
    vim.api.nvim_win_set_cursor(0, { row + 1, column })
  end, {})
end

return M
