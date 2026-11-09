-- Quit nvim after vim.g.idle_quit_minutes (10) without focus or a key,
-- saving its windows as a session that `v` (and `nr`) restore. Each
-- idle nvim holds 100+ MB and a revived tmux server starts one per
-- session. Never quits with unsaved changes or a running terminal job
-- (fzf pickers excepted): it tries again a period later.
local M = {}

local timer = assert(vim.uv.new_timer())
local focused = nil -- unknown until tmux reports a focus change

local function idle_ms()
  return (vim.g.idle_quit_minutes or 10) * 60 * 1000
end

-- Session file for this nvim: in its worktree's git dir (removed with
-- the worktree, never in git status), else nvim's state dir, keyed by
-- server name. bin/v derives the same path.
local start_dir = vim.fn.getcwd()

function M.session_path()
  local name = vim.fn.fnamemodify(vim.v.servername, ":t")
  if not name:match "^nvim%-server%-" then
    return nil
  end
  local gd = vim.fn.systemlist {
    "git", "-C", start_dir, "rev-parse", "--absolute-git-dir",
  }[1]
  if vim.v.shell_error == 0 and gd and gd ~= "" then
    return gd .. "/nvim-idle-session.vim"
  end
  return vim.fn.stdpath "state" .. "/idle-sessions/" .. name .. ".vim"
end

local function blocked()
  for _, b in ipairs(vim.fn.getbufinfo { bufloaded = 1 }) do
    -- Prompt and scratch buffers (Telescope's) are always "changed".
    if b.changed == 1 and vim.bo[b.bufnr].buftype == "" then
      return "unsaved " .. (b.name ~= "" and b.name or "buffer")
    end
    local bt = vim.bo[b.bufnr].buftype
    local ft = vim.bo[b.bufnr].filetype
    if bt == "terminal" and ft ~= "fzf" then
      local job = vim.b[b.bufnr].terminal_job_id
      if job and vim.fn.jobwait({ job }, 0)[1] == -1 then
        return "running terminal"
      end
    end
  end
end

local function has_files()
  for _, b in ipairs(vim.fn.getbufinfo { buflisted = 1 }) do
    if b.name ~= "" and vim.bo[b.bufnr].buftype == "" then
      return true
    end
  end
  return false
end

function M.quit()
  if focused or blocked() then
    return M.arm()
  end
  local path = M.session_path()
  if path then
    -- Close pickers and other non-file windows first, so the session
    -- holds only files.
    for _, w in ipairs(vim.api.nvim_list_wins()) do
      local b = vim.api.nvim_win_get_buf(w)
      if vim.bo[b].buftype ~= "" and #vim.api.nvim_list_wins() > 1 then
        pcall(vim.api.nvim_win_close, w, true)
      end
    end
    if has_files() then
      vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")
      local so = vim.o.sessionoptions
      vim.o.sessionoptions = "buffers,curdir,folds,tabpages,winsize"
      pcall(vim.cmd, "mksession! " .. vim.fn.fnameescape(path))
      vim.o.sessionoptions = so
    else
      os.remove(path)
    end
  end
  M.quitting = true
  vim.cmd "qa!"
end

function M.arm()
  timer:stop()
  timer:start(idle_ms(), 0, vim.schedule_wrap(M.quit))
end

function M.status()
  return (focused and "focused" or "unfocused") .. " " .. timer:get_due_in()
end

function M.setup()
  if M.done then
    return
  end
  M.done = true
  local group = vim.api.nvim_create_augroup("jrasmusbm_idle_quit", {})
  vim.api.nvim_create_autocmd("FocusLost", {
    group = group,
    callback = function()
      focused = false
      M.arm()
    end,
  })
  vim.api.nvim_create_autocmd("FocusGained", {
    group = group,
    callback = function()
      focused = true
      timer:stop()
    end,
  })
  -- A key counts as presence when tmux never reported focus (an nvim
  -- started in the window I'm looking at).
  vim.on_key(function()
    if not focused then
      M.arm()
    end
  end, vim.api.nvim_create_namespace "jrasmusbm_idle_quit")
  -- Only an idle quit leaves a session behind: after a quit of my own,
  -- the next `v` starts fresh.
  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = group,
    callback = function()
      local path = M.session_path()
      if path and not M.quitting then
        os.remove(path)
      end
    end,
  })
  vim.api.nvim_create_user_command("IdleQuitNow", function()
    focused = false
    M.quit()
  end, {})
  M.arm()
end

return M
