return {
  "L3MON4D3/LuaSnip",
  config = function()
    local ls = require "luasnip"
    require "jrasmusbm.snippets.shared.all"

    ls.config.set_config {
      history = true,
      updateevents = "TextChanged,TextChangedI",
    }

    ls.filetype_extend("tsx", { "html", "css" })
    ls.filetype_extend("jsx", { "html", "css" })
    ls.filetype_extend("typescript", { "graphql" })
    ls.filetype_extend("graphql", { "javascript" })
  end,
}
