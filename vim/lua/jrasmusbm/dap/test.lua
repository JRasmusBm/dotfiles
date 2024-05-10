local M = {}

local state = {
  previous = nil,
}

local debug_test = function(cmd, debug_handlers, callback)
  return vim.schedule_wrap(function()
    local original_handlers = {}

    for k, v in pairs(debug_handlers) do
      original_handlers[k] = vim.g[k]
      vim.g[k] = v
    end

    vim.cmd(cmd)

    for k, v in pairs(original_handlers) do
      vim.g[k] = v
    end

    callback()

    state.previous = {
      cmd = cmd,
      debug_handlers = debug_handlers,
      callback = callback,
    }
  end)
end

local run_last_test = function()
  if state.previous == nil then
    return
  end

  debug_test(state.previous.cmd)(
    state.previous.debug_handlers,
    state.previous.callback
  )
end

M.setup_test_debugging = function(...)
  vim.keymap.set(
    { "n" },
    "<localleader>din",
    debug_test("TestNearest", ...),
    { noremap = true, buffer = 0 }
  )
  vim.keymap.set(
    { "n" },
    "<localleader>dif",
    debug_test("TestFile", ...),
    { noremap = true, buffer = 0 }
  )
  vim.keymap.set(
    { "n" },
    "<localleader>dis",
    debug_test("TestSuite", ...),
    { noremap = true, buffer = 0 }
  )
  vim.keymap.set({ "n" }, "<localleader>dip", run_last_test, { noremap = true })
end

return M
