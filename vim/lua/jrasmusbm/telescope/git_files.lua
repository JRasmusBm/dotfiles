local M = {}

M.git_files = function(options)
    require('telescope.builtin').git_files({
        attach_mappings = function(prompt_bufnr, map)
            local create_new_file = require(
                                        "jrasmusbm.telescope.create_new_file").create_new_file(
                                        options or {}, prompt_bufnr)

            map('i', '<C-e>', create_new_file)
            map('n', '<C-e>', create_new_file)

            return true
        end
    })
end

return M
