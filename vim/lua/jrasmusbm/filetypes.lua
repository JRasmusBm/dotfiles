local M = {}

M.css = { "css" }
M.go = { "go" }
M.html = { "html" }
M.javascript = { "javascript" }
M.json = { "json" }
M.latex = { "tex", "latex", "context", "plaintex" }
M.lua = { "lua" }
M.markdown = { "markdown" }
M.python = { "python", "python.unittest", "python.pytest" }
M.rust = { "rust" }
M.sh = { "sh", "bash" }
M.terraform = { "terraform" }
M.graphql = { "graphql" }
M.typescript = {
  "typescript",
  "typescriptreact",
  "typescript.express",
  "typescript.tsx",
  "typescript.tsx.remix",
  "typescript.typescript_jest",
  "typescript.express.typescript_mocha",
}
M.tsx = { "typescript.tsx", "typescriptreact", "javascript.jsx" }
M.zsh = { "zsh" }

return M
