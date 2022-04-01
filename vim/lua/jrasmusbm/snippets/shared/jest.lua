local ls = require "luasnip"
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node

local s = function(context, nodes, options)
  return function()
    return ls.s(context, nodes, options)
  end
end

return {
  s(
    { trig = "dp", name = "patch module" },
    fmt('jest.mock("{}")\n{}', { i(1), i(0) })
  ),

  s(
    { trig = "dex", name = "regex match" },
    fmt("expect.stringMatching(/{}/){}", { i(1), i(0) })
  ),
  s(
    { trig = "de", name = "expect" },
    fmt("expect({}).{}\n{}", { i(1), i(2), i(0) })
  ),
}
