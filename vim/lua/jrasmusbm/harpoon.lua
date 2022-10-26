local M = {}

M.ensure_setup = function()
  if not require("jrasmusbm.utils").ensure_loaded "harpoon" then
    return false
  end

  require("harpoon").setup {
    global_settings = {
      save_on_toggle = true,
      save_on_change = true,
      mark_branch = true,
    },
  }
  return true
end

return M
