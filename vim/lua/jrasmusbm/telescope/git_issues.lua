local M = {}

local Job = require('plenary.job')
local utils = require("telescope.utils")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local previewers = require("telescope.previewers")

M.git_issues = function()
    local results = utils.get_os_command_output({'g', 'li'})

    pickers.new({}, {
        prompt_title = 'Git Issues',
        finder = finders.new_table {
            results = results,
            entry_maker = function(line)
                local raw_line_parts = vim.split(line, "\t")
                local sections = {
                    id = raw_line_parts[1],
                    status = raw_line_parts[2],
                    title = raw_line_parts[3],
                    unknown = raw_line_parts[4],
                    date = vim.split(raw_line_parts[5], " ")[1]
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
                return {"gh", "issue", "view", entry.id}
            end
        }),
        sorter = sorters.get_generic_fuzzy_sorter(),
        attach_mappings = function(prompt_bufnr, map)
            local checkout = function()
                local selection = action_state.get_selected_entry()
                local command = "echo \"" ..
                                    (selection.id .. " " .. selection.title) ..
                                    "\" | tr -cd \"[\\-a-zA-Z0-9 ]\" | tr \"[:upper:] \" \"[:lower:]-\""

                local branch_name = vim.fn.system(command)

                actions.close(prompt_bufnr)
                vim.api.nvim_command('!git ch ' .. branch_name .. '|| git ch -b ' .. branch_name)
            end

            local open_in_browser = function()
                local selection = action_state.get_selected_entry()

                actions.close(prompt_bufnr)
                vim.api.nvim_command('!gh issue view --web ' .. selection.id)
            end

            local close_issue = function()
                local selection = action_state.get_selected_entry()

                actions.close(prompt_bufnr)
                vim.fn.jobstart('gh issue close ' .. selection.id)
            end

            map('i', '<C-d>', close_issue)
            map('n', '<C-d>', close_issue)

            map('i', '<C-b>', open_in_browser)
            map('n', '<C-b>', open_in_browser)

            actions.select_default:replace(checkout)
            return true
        end
    }):find()
end

return M
