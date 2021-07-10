local M = {}

local action_state = require("telescope.actions.state")

M.git_commits = function(options_)
    local options = options_ or {}
    options["attach_mappings"] = function(_, map)
        local rebase_interactive = function()
            local selection = action_state.get_selected_entry()
            vim.api.nvim_command('G rbi ' .. selection.value)
        end

        map('i', '<C-i>', rebase_interactive)
        map('n', '<C-i>', rebase_interactive)

        return true
    end

    require('telescope.builtin').git_commits(options)
end

return M
