local M = {}

local default_options = {
  extensions = {
    j = "jasmin",
    jsx = "javascript.jsx",
    tf = "terraform",
    graphql = "graphql",
    toml = "toml",
    tex = "tex",
    scm = "query",
    tsx = "typescript.tsx",
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
    [".tmux-speeddial"] = "speeddial",
    EDIT_DESCRIPTION = "gitcommit",
  },
  complex = {
    ["%.env.*"] = "sh",
    ["Dockerfile.*"] = "dockerfile",
    [".*%.test%.ts"] = "typescript.typescript_jest",
    [".*%.test%.tsx"] = "typescript.tsx.typescript_jest",
    [".*%.cy%.ts"] = "typescript.typescript_cypress",
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
    return require("filetype").setup { overrides = default_options }
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

  return require("filetype").setup { overrides = options }
end

return M
