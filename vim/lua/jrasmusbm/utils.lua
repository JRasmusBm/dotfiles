local M = {}

M.space = function(n) return string.rep(" ", n) end

M.echo_success = function(message)
    vim.cmd("silent! echohl MoreMsg | echo '" .. message .. "' | echohl None")
    vim.cmd('redraw!')
end

M.echo_error = function(message)
    vim.cmd("silent! echohl Error | echo '" .. message .. "' | echohl None")
    vim.cmd('redraw!')
end

M.echo_info = function(message)
    vim.cmd("silent! echohl ModeMsg | echo '" .. message .. "' | echohl None")
    vim.cmd('redraw!')
end

return M
