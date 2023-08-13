local ensure_setup = require("jrasmusbm.dap").ensure_setup

vim.keymap.set({ "n" }, "<leader>i<Esc>", function()
  ensure_setup()
  require("dap").disconnect()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>ip", function()
  ensure_setup()
  require("dap").run_last()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>ij", function()
  ensure_setup()
  require("dap").step_over()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>iJ", function()
  ensure_setup()
  require("dap").run_to_cursor()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>ik", function()
  ensure_setup()
  require("dap").step_back()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>il", function()
  ensure_setup()
  require("dap").step_into()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>ih", function()
  ensure_setup()
  require("dap").step_out()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>iH", function()
  ensure_setup()
  require("dap").up()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>iL", function()
  ensure_setup()
  require("dap").down()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>ic", function()
  ensure_setup()
  require("dap").continue()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>iC", function()
  ensure_setup()
  require("dap").reverse_continue()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>ib", function()
  ensure_setup()
  require("dap").toggle_breakpoint()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>iB", function()
  ensure_setup()
  require("dap").list_breakpoints(true)
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>im", function() -- Maybe break
  ensure_setup()
  require("dap").toggle_breakpoint(vim.fn.input "Break on: ")
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>ie", function()
  ensure_setup()
  require("dap").set_exception_breakpoints "default"
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>iw", function()
  ensure_setup()
  require("dapui").toggle()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>id", function() -- Details
  ensure_setup()
  require("dapui").eval()
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>if", function()
  ensure_setup()
  require("jrasmusbm.telescope").ensure_setup()
  require("telescope").extensions.dap.frames {}
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>ix", function()
  ensure_setup()
  require("jrasmusbm.telescope").ensure_setup()
  require("telescope").extensions.dap.commands {}
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>iv", function()
  ensure_setup()
  require("jrasmusbm.telescope").ensure_setup()
  require("telescope").extensions.dap.variables {}
end, { noremap = true })

vim.keymap.set({ "n" }, "<leader>i<enter>", function()
  ensure_setup()
  require("jrasmusbm.telescope").ensure_setup()
  require("telescope").extensions.dap.configurations {
    language_filter = function(lang)
      return lang == vim.bo.filetype
    end,
  }
end, { noremap = true })
