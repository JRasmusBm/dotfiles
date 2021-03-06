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
        prompt_title = 'Git Commits',
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
                print(vim.inspect({
                    file = "/home/jrasmusbm/.vim/lua/jrasmusbm/telescope/git_issues.lua",
                    line = 40,
                    entry
                }))
                return {"gh", "issue", "view", entry.id}
            end
        }),
        sorter = sorters.get_generic_fuzzy_sorter(),
        attach_mappings = function(prompt_bufnr)
            local checkout = function()
                local selection = action_state.get_selected_entry()
                local command = "echo \"" ..
                                    (selection.id .. " " .. selection.title) ..
                                    "\" | tr -cd \"[\\-a-zA-Z0-9 ]\" | tr \"[:upper:] \" \"[:lower:]-\""

                local branch_name = vim.fn.system(command)

                actions.close(prompt_bufnr)
                vim.api.nvim_command('G ch ' .. branch_name)
            end

            actions.select_default:replace(checkout)
            return true
        end
    }):find()
end

return M
