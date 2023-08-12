local M = {}

M.setup = function()
  vim.g["test#javascript#runner"] = "jest"
  vim.g["test#javascript#jest#executable"] = "npm run test --"
  vim.g["test#javascript#jest#options"] = {
    nearest = "--forceExit --verbose --no-coverage --watchAll=false",
    file = "--forceExit --verbose --no-coverage --watchAll=false",
    suite = "--forceExit --verbose --watchAll=false",
  }
end

return M
