local M = {}

M.main = function(mapping, path_lists, silent)
  vim.keymap.set({ "n" }, mapping, function()
    local node =
      require("jrasmusbm.treesitter.utils").up_and_down(path_lists, silent)

    if node == nil then
      print "Could not find a node to jump to!"
      return
    end

    local row, column = node:start()

    vim.cmd.normal "m`"
    vim.api.nvim_win_set_cursor(0, { row + 1, column })
  end, {})
end

return M
