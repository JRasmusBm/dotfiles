local M = {}

local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local Path = require("plenary.path")

M.create_new_file = function(options, prompt_bufnr)
    return function()
        local file = action_state.get_current_line()

        if options and options.cwd then
            file = options.cwd .. Path.path.sep .. file
        end

        actions.close(prompt_bufnr)
        vim.cmd(string.format(':e %s', file))
    end
end

return M
