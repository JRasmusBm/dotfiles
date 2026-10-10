local M = {}

local HEAVY = { "ts_ls", "eslint" }

local timer = assert(vim.uv.new_timer())
local suspended = false
local unfocused_since = 0

local function idle_ms()
  return (vim.g.lsp_idle_minutes or 30) * 60 * 1000
end

function M.suspend()
  for _, name in ipairs(HEAVY) do
    for _, client in ipairs(vim.lsp.get_clients { name = name }) do
      client:stop()
      vim.defer_fn(function()
        if vim.lsp.get_client_by_id(client.id) then
          client.rpc.terminate()
        end
      end, 10000)
      suspended = true
    end
  end
end

function M.resume()
  if not suspended then
    return
  end
  suspended = false
  for _, name in ipairs(HEAVY) do
    local manager = require("lspconfig")[name].manager
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buf) then
        manager:try_add_wrapper(buf)
      end
    end
  end
end

function M.status()
  local n = 0
  for _, name in ipairs(HEAVY) do
    n = n + #vim.lsp.get_clients { name = name }
  end
  return unfocused_since .. " " .. n
end

function M.setup()
  local group = vim.api.nvim_create_augroup("jrasmusbm_lsp_idle", {})
  vim.api.nvim_create_autocmd("FocusLost", {
    group = group,
    callback = function()
      unfocused_since = os.time()
      timer:start(idle_ms(), 0, vim.schedule_wrap(M.suspend))
    end,
  })
  vim.api.nvim_create_autocmd("FocusGained", {
    group = group,
    callback = function()
      unfocused_since = 0
      timer:stop()
      M.resume()
    end,
  })
  vim.api.nvim_create_user_command("LspSuspend", M.suspend, {})
  vim.api.nvim_create_user_command("LspResume", M.resume, {})
end

return M
