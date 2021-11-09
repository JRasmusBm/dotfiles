local M = {}

M.space = function(n) return string.rep(" ", n) end

M.echo_success = function(message)
  vim.cmd("silent! echohl MoreMsg | echo '" .. message .. "' | echohl None")
  vim.cmd("redraw!")
end

M.echo_error = function(message)
  vim.cmd("silent! echohl Error | echo '" .. message .. "' | echohl None")
  vim.cmd("redraw!")
end

M.echo_info = function(message)
  vim.cmd("silent! echohl ModeMsg | echo '" .. message .. "' | echohl None")
  vim.cmd("redraw!")
end

M.for_each_file_in_directory = function(cwd, fn)
  require("plenary.job"):new({
    command = "ls",
    cwd = cwd,
    on_exit = vim.schedule_wrap(function(j)
      for _, file in ipairs(j:result()) do fn(file) end
    end),
  }):start()

end

return M
