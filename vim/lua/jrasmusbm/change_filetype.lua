local M = {}

M.is_typescript_test_file = function()
  local path_segments = vim.split(vim.api.nvim_buf_get_name(0), "%.")

  return path_segments[#path_segments - 1] == "test"
    or path_segments[#path_segments - 1] == "spec"
end

local default_options = {
  extensions = {
    j = "jasmin",
    jsx = "javascript.jsx",
    tf = "terraform",
    graphql = "graphql",
    toml = "toml",
    tex = "tex",
    scm = "query",
    sql = "sql",
    sh = "sh",
    html = "html",
  },
  literal = {
    [".eslintrc"] = "json",
    [".babelrc"] = "json",
    [".stylelintrc"] = "json",
    [".swcrc"] = "json",
    [".prettierrc"] = "json",
    [".graphite_cache_persist"] = "json",
    [".pylintrc"] = "dosini",
    [".coveragerc"] = "dosini",
    [".flake8"] = "dosini",
    [".tmux"] = "sh",
    [".tmux-default"] = "sh",
    [".sequelizerc"] = "javascript",
    gitconfig = "gitconfig",
    [".rgignore"] = "gitignore",
    [".ignore"] = "gitignore",
    ["serviceworker.ts"] = "typescript.serviceworker",
    ["serviceworker.js"] = "javascript.serviceworker",
    branch_speeddial = "speeddial",
    EDIT_DESCRIPTION = "gitcommit",
  },
  complex = {
    ["ts-*"] = "speeddial",
    ["%.env.*"] = "sh",
    ["Dockerfile.*"] = "dockerfile",
    [".*%.cy%.ts"] = "typescript.typescript_cypress",
  },
  function_extensions = {
    tsx = function()
      if M.is_typescript_test_file() then
        vim.bo.filetype = "typescript.tsx.typescript_jest"
      else
        vim.bo.filetype = "typescript.tsx"
      end
    end,
    ts = function()
      if M.is_typescript_test_file() then
        vim.bo.filetype = "typescript.typescript_jest"
      else
        vim.bo.filetype = "typescript"
      end
    end,
  },
}

local option_names = {
  "extensions",
  "literal",
  "complex",
  "function_extensions",
  "function_literal",
  "function_complex",
  "shebang",
}

local merge_options = function(option_name, overrides, ignore_keys)
  local result = {}

  for key, value in pairs(default_options[option_name] or {}) do
    if ignore_keys[key] ~= true then
      result[key] = value
    end
  end

  for key, value in pairs(overrides[option_name] or {}) do
    result[key] = value
  end

  return result
end

M.setup = function(overrides)
  if overrides == nil then
    return
  end

  local ignore_keys = {}
  for _, subtable in pairs(overrides) do
    for key, _ in pairs(subtable) do
      ignore_keys[key] = true
    end
  end

  local options = {}

  for _, option_name in ipairs(option_names) do
    options[option_name] = merge_options(option_name, overrides, ignore_keys)
  end

  return vim.filetype.add(options)
end

return M
