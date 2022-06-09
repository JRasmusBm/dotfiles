vim.keymap.set({ "n" }, "<leader>i<Esc>", function()
  require("dap").disconnect()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>ip", function()
  require("dap").run_last()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>ij", function()
  require("dap").step_over()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>iJ", function()
  require("dap").run_to_cursor()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>ik", function()
  require("dap").step_back()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>il", function()
  require("dap").step_into()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>ih", function()
  require("dap").step_out()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>iH", function()
  require("dap").up()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>iL", function()
  require("dap").down()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>ic", function()
  require("dap").continue()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>iC", function()
  require("dap").reverse_continue()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>ib", function()
  require("dap").toggle_breakpoint()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>iB", function()
  require("dap").list_breakpoints(true)
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>im", function() -- Maybe break
  require("dap").toggle_breakpoint(vim.fn.input "Break on: ")
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>ie", function()
  require("dap").set_exception_breakpoints "default"
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>iw", function()
  require("dapui").toggle()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>id", function() -- Details
  require("dapui").eval()
end, { noremap = true })

local M = {}

M.telescope_mappings = function()
  vim.keymap.set({ "n" }, "<leader>if", function()
    require("telescope").extensions.dap.frames {}
  end, { noremap = true })

  vim.keymap.set({ "n" }, "<leader>ix", function()
    require("telescope").extensions.dap.commands {}
  end, { noremap = true })

  vim.keymap.set({ "n" }, "<leader>iv", function()
    require("telescope").extensions.dap.variables {}
  end, { noremap = true })

  vim.keymap.set({ "n" }, "<leader>i<enter>", function()
    require("telescope").extensions.dap.configurations {}
  end, { noremap = true })

end

return M
