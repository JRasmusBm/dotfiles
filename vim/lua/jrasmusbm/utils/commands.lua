local M = {}

M.mapped_args = function(options)
  local result = {}

  if #options.fargs > 0 then
    result.args = { vim.fn.join(options.fargs, " ") }
  end

  if options.count ~= -1 then
    result.count = options.count
  end

  if options.range ~= 0 then
    result.range = { options.line1, options.line2 }
  end

  result.bang = options.bang

  return result
end

M.run = function(command_name, options)
  local args = M.mapped_args(options)

  args.cmd = command_name

  vim.cmd(args)
end

return M
