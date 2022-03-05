local M = {}

local debug_test = function(cmd, debug_handlers, callback)
  local original_handlers = {}

  for k, v in pairs(debug_handlers) do
    original_handlers[k] = vim.g[k]
    vim.g[k] = v
  end

  vim.cmd(cmd)

  for k, v in pairs(original_handlers) do vim.g[k] = v end

  vim.defer_fn(vim.schedule_wrap(callback), 500)
end

M.setup_test_debugging = function(...)
  vim.keymap.set({"n"}, "din", debug_test("TestNearest", ...),
                 {noremap = true, buffer = 0})
  vim.keymap.set({"n"}, "dip", debug_test("TestLast", ...),
                 {noremap = true, buffer = 0})
  vim.keymap.set({"n"}, "dif", debug_test("TestFile", ...),
                 {noremap = true, buffer = 0})
  vim.keymap.set({"n"}, "dis", debug_test("TestSuite", ...),
                 {noremap = true, buffer = 0})
end

return M
