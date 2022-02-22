local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node

local s = function(context, nodes, options)
  return function() return ls.s(context, nodes, options) end
end

return {
  s({trig = "he", name = "useEffect hook"},
    fmt("useEffect(() => {{\n  {}\n}}, [{}])\n\n{}", {i(1), i(2), i(0)})),
  s({trig = "hl", name = "useLayoutEffect hook"},
    fmt("useLayoutEffect(() => {{\n  {}\n}}, [{}])\n\n{}", {i(1), i(2), i(0)})),
}
