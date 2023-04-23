local M = {}

M.run_with_range = function(command)
  local visual_start = vim.fn.getpos("v")[2]
  local visual_end = vim.fn.getpos(".")[2]

  if visual_start > visual_end then
    local temp = visual_start
    visual_start = visual_end
    visual_end = temp
  end

  local cmd = string.format("%s,%s%s", visual_start, visual_end, command)

  vim.cmd(cmd)
end

return M
