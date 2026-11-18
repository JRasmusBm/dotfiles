-- :Ski [name] opens a Claude skill's SKILL.md wherever it lives: the
-- repo's .claude/skills (nearest dir from cwd to the git root wins),
-- else ~/.claude/skills. Symlinks resolve, so private-overlay skills
-- open at their source. No name: pick one (telescope via ui-select).
-- Also lists what a session here loads besides skills: the CLAUDE.md
-- files from cwd up to / plus ~/.claude's, and the flow skill's nodes.

local function skill_dirs()
  local global = vim.fn.expand "~/.claude/skills"
  local dirs = {}
  local root = vim.fs.root(0, ".git") or vim.fn.getcwd()
  local dir = vim.fn.getcwd()
  while true do
    local path = dir .. "/.claude/skills"
    if path ~= global then
      table.insert(dirs, { label = "repo", path = path })
    end
    if dir == root or dir == "/" then
      break
    end
    dir = vim.fs.dirname(dir)
  end
  table.insert(dirs, { label = "global", path = global })
  return dirs
end

-- name -> { label, file }, first scope wins (as in Claude Code)
local function skills()
  local found, order = {}, {}
  for _, d in ipairs(skill_dirs()) do
    for name, kind in vim.fs.dir(d.path) do
      local file = d.path .. "/" .. name .. "/SKILL.md"
      if
        kind ~= "file"
        and not found[name]
        and vim.fn.filereadable(file) == 1
      then
        found[name] = { label = d.label, file = vim.fn.resolve(file) }
        table.insert(order, name)
      end
    end
  end
  local function add(name, label, file)
    if not found[name] and vim.fn.filereadable(file) == 1 then
      found[name] = { label = label, file = vim.fn.resolve(file) }
      table.insert(order, name)
    end
  end
  local dir = vim.fn.getcwd()
  while true do
    for _, f in ipairs { "CLAUDE.md", ".claude/CLAUDE.md", "CLAUDE.local.md" } do
      local file = dir .. "/" .. f
      add(vim.fn.fnamemodify(file, ":~"), "claude", file)
    end
    if dir == "/" then
      break
    end
    dir = vim.fs.dirname(dir)
  end
  add("~/.claude/CLAUDE.md", "claude", vim.fn.expand "~/.claude/CLAUDE.md")
  if found.flow then
    local nodes = vim.fs.dirname(found.flow.file) .. "/nodes"
    for name, kind in vim.fs.dir(nodes) do
      if kind == "file" and name:match "%.md$" then
        add("flow/" .. name:gsub("%.md$", ""), "flow", nodes .. "/" .. name)
      end
    end
  end
  table.sort(order)
  return found, order
end

local function open(skill)
  vim.cmd.edit(vim.fn.fnameescape(skill.file))
end

vim.api.nvim_create_user_command("Ski", function(opts)
  local found, order = skills()
  if opts.args ~= "" then
    local skill = found[opts.args]
    if not skill then
      vim.notify("No skill " .. opts.args, vim.log.levels.ERROR)
      return
    end
    return open(skill)
  end
  vim.ui.select(order, {
    prompt = "Skill",
    format_item = function(name)
      return found[name].label .. ": " .. name
    end,
  }, function(name)
    if name then
      open(found[name])
    end
  end)
end, {
  nargs = "?",
  complete = function(lead)
    local _, order = skills()
    return vim.tbl_filter(function(name)
      return vim.startswith(name, lead)
    end, order)
  end,
})
