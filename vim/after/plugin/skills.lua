-- :Ski [name] opens a Claude skill's SKILL.md wherever it lives: the
-- repo's .claude/skills (nearest dir from cwd to the git root wins),
-- else ~/.claude/skills. Symlinks resolve, so private-overlay skills
-- open at their source. No name: pick one (telescope via ui-select).

local function skill_dirs()
  local dirs = {}
  local root = vim.fs.root(0, ".git") or vim.fn.getcwd()
  local dir = vim.fn.getcwd()
  while true do
    table.insert(dirs, { label = "repo", path = dir .. "/.claude/skills" })
    if dir == root or dir == "/" then break end
    dir = vim.fs.dirname(dir)
  end
  table.insert(dirs, {
    label = "global",
    path = vim.fn.expand "~/.claude/skills",
  })
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
    if name then open(found[name]) end
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
