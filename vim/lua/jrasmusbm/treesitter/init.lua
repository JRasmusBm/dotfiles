require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    highlight = {enable = true},
    textobjects = {
        select = require("jrasmusbm.treesitter.select").select,
        swap = require("jrasmusbm.treesitter.swap").swap,
        move = require("jrasmusbm.treesitter.move").move
    }
}
