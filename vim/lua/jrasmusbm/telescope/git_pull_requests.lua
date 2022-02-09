local M = {}

local utils = require("telescope.utils")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local previewers = require("telescope.previewers")

M.git_pull_requests = function()
    local results = utils.get_os_command_output({'gh', 'pr', 'list'})

    pickers.new({}, {
        prompt_title = 'Git Pull Requests',
        finder = finders.new_table {
            results = results,
            entry_maker = function(line)
                local raw_line_parts = vim.split(line, "\t")
                local sections = {
                    id = raw_line_parts[1],
                    title = raw_line_parts[2],
                    branch = raw_line_parts[3],
                    status = raw_line_parts[4]
                }
                return {
                    value = line,
                    ordinal = line,
                    display = sections.id .. " " .. " " .. sections.title,
                    id = sections.id,
                    title = sections.title
                }
            end
        },
        previewer = previewers.new_termopen_previewer({
            title = "Issue Preview",
            get_command = function(entry)
                return {"gh", "pr", "view", entry.id}
            end
        }),
        sorter = sorters.get_generic_fuzzy_sorter(),
        attach_mappings = function(prompt_bufnr, map)
            local switch = function()
                local selection = action_state.get_selected_entry()

                actions.close(prompt_bufnr)
                vim.api.nvim_command('G pr ' .. selection.id)
            end

            local open_in_browser = function()
                local selection = action_state.get_selected_entry()

                actions.close(prompt_bufnr)
                vim.api.nvim_command('!gh pr view --web ' .. selection.id)
            end

            map('i', '<C-b>', open_in_browser)
            map('n', '<C-b>', open_in_browser)
            actions.select_default:replace(switch)
            return true
        end
    }):find()
end

return M
