local ls = require "luasnip"
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local rep = require("luasnip.extras").rep

local s = function(context, nodes, options)
  return function()
    return ls.s(context, nodes, options)
  end
end

return {
  s(
    { trig = "qu", name = "graphql query" },
    fmt("query {} {{\n  {}\n}}\n\n{}", { i(1), i(2), i(0) })
  ),
  s(
    { trig = "qt", name = "graphql type" },
    fmt("type {} {{\n  {}\n}}\n\n{}", { i(1), i(2), i(0) })
  ),
  s(
    { trig = "qm", name = "graphql mutation" },
    fmt("mutation {} {{\n  {}\n}}\n\n{}", { i(1), i(2), i(0) })
  ),
  s(
    { trig = "qf", name = "graphql field" },
    fmt("{} {{\n  {}\n}}\n\n{}", { i(1), i(2), i(0) })
  ),

  s(
    { trig = "qv", name = "graphql variable" },
    fmt("${}: {}!{}", { i(1), i(2), i(0) })
  ),
  s(
    { trig = "qa", name = "graphql argument" },
    fmt("{}: ${}{}", { i(1), rep(1), i(0) })
  ),

  s(
    { trig = "qn", name = "__typename" },
    fmt('__typename: "{}"\n{}', { i(1), i(0) })
  ),
  s(
    { trig = "doc", name = "docstring" },
    fmt(
      [[
"""
{}
"""
]],
      { i(0) }
    )
  ),
}
