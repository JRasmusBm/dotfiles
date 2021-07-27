local M = {}

M.select = {
    enable = true,
    lookahead = true,
    keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["adc"] = "@test.case.outer",
        ["ads"] = "@test.suite.outer",
        ["aS"] = "@statement.outer"
    }
}

return M
