local M = {}

local actions = require("telescope.actions")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local action_state = require("telescope.actions.state")

M.refresh = function(prompt_bufnr)
    local prev_picker = action_state.get_current_picker(prompt_bufnr)
    local entries = {}
    for entry in prev_picker.manager.linked_states:iter() do
        table.insert(entries, entry[1])
    end

    actions.close(prompt_bufnr)

    pickers.new({}, {
        finder = finders.new_table {
            results = entries,
            entry_maker = function(entry) return entry end
        },
        prompt_title = prev_picker.prompt_title,
        previewer = prev_picker.previewer,
        sorter = sorters.get_generic_fuzzy_sorter(),
        attach_mappings = prev_picker.attach_mappings
    }):find()
end

return M
