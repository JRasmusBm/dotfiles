local main_roots = {}
local active

local function main_root(worktree_root)
  if main_roots[worktree_root] == nil then
    local common_dir = vim.fn.systemlist({
      "git",
      "-C",
      worktree_root,
      "rev-parse",
      "--path-format=absolute",
      "--git-common-dir",
    })[1]
    main_roots[worktree_root] = vim.v.shell_error == 0
        and vim.fs.dirname(common_dir)
      or worktree_root
  end
  return main_roots[worktree_root]
end

local function project_for(dir)
  local worktree_root = vim.fs.root(dir, ".git")
  if not worktree_root then
    return
  end
  local config_root = main_root(worktree_root)
  local rel = dir:sub(#worktree_root + 2)
  while true do
    local config = vim.fs.joinpath(config_root, rel, ".jrb", "init.lua")
    if vim.uv.fs_stat(config) then
      return {
        config = config,
        dir = vim.fs.dirname(config),
        root = vim.fs.joinpath(worktree_root, rel),
      }
    end
    if rel == "" then
      return
    end
    rel = rel:match("^(.*)/[^/]*$") or ""
  end
end

local function apply(project)
  if not project or project.config == active then
    return
  end
  active = project.config
  vim.g.jrb_dir = project.dir
  vim.g.jrb_root = project.root
  vim.g["test#project_root"] = project.root
  vim.api.nvim_create_augroup("project_files", { clear = true })
  require("jrasmusbm.change_filetype").setup()
  vim.cmd.source(vim.fn.fnameescape(project.config))
end

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("local_config", { clear = true }),
  callback = function(args)
    local path = vim.api.nvim_buf_get_name(args.buf)
    if path:sub(1, 1) == "/" then
      apply(project_for(vim.fs.dirname(path)))
    end
  end,
})

apply(project_for(vim.fn.getcwd()))

vim.api.nvim_create_user_command("Prc", function()
  vim.cmd.edit(vim.fn.fnameescape(vim.g.jrb_dir or "./.jrb"))
end, {})
