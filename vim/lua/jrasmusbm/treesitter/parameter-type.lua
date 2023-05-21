local M = {}

M.setup_parameter_mappings = function(list_pairs)
  vim.keymap.set({ "n" }, "<leader>ap", function()
    local node =
      require("jrasmusbm.treesitter.utils").up_and_down(list_pairs, true)

    if node == nil then
      print "Could not find parameter!"
      return
    end

    local row, column = node:start()

    vim.cmd.normal "m`"
    vim.api.nvim_win_set_cursor(0, { row + 1, column })
  end, {})
end

return M
