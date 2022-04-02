local M = {}

M.in_termux = function ()
 return vim.fn.match(vim.fn.getenv("PREFIX"), "com.termux") ~= -1
end

return M
