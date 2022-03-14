local M = {}

M.list = function(value, str, sep)
  sep = sep or ","
  str = str or ""
  value = type(value) == "table" and table.concat(value, sep) or value
  return str ~= "" and table.concat({ value, str }, sep) or value
end

return M
