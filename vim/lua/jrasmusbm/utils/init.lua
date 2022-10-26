local M = {}

M.space = function(n)
  return string.rep(" ", n)
end

M.echo_success = function(message)
  vim.cmd("silent! echohl MoreMsg | echo '" .. message .. "' | echohl None")
  vim.cmd "redraw!"
end

M.echo_error = function(message)
  vim.cmd("silent! echohl Error | echo '" .. message .. "' | echohl None")
  vim.cmd "redraw!"
end

M.echo_info = function(message)
  vim.cmd("silent! echohl ModeMsg | echo '" .. message .. "' | echohl None")
  vim.cmd "redraw!"
end

M.for_each_file_in_directory = function(cwd, fn)
  require("plenary.job")
    :new({
      command = "ls",
      cwd = cwd,
      on_exit = vim.schedule_wrap(function(j)
        for _, file in ipairs(j:result()) do
          fn(file)
        end
      end),
    })
    :start()
end

M.has_line_matching = function(regex)
  print(vim.inspect {
    file = "/home/jrasmusbm/dotfiles/vim/lua/jrasmusbm/utils/init.lua",
    line = 43,
  })
  for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
    print(vim.inspect {
      file = "/home/jrasmusbm/dotfiles/vim/lua/jrasmusbm/utils/init.lua",
      line = 51,
    })
    if (vim.regex(regex)):match_str(line) then
      print(vim.inspect {
        file = "/home/jrasmusbm/dotfiles/vim/lua/jrasmusbm/utils/init.lua",
        line = 53,
      })
      return true
    end
  end

  return false
end

local loaded_plugins = {}

M.ensure_setup = function(plugin_name)
  if loaded_plugins[plugin_name] == true then
    return false
  end

  vim.cmd("packadd " .. plugin_name)
  loaded_plugins[plugin_name] = true
  return true
end

return M
