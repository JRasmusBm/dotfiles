local M = {}

local action_state = require("telescope.actions.state")

M.git_branches = function(options_)
    local options = options_ or {}
    options["attach_mappings"] = function(_, map)
        local reset_hard = function()
            local selection = action_state.get_selected_entry()
            vim.api.nvim_command('Git rh ' .. selection.value)
        end

        map('i', '<C-h>', reset_hard)
        map('n', '<C-h>', reset_hard)

        return true
    end

    require('telescope.builtin').git_branches(options)
end

return M
