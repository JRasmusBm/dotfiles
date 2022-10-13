local ls = require "luasnip"
local fmt = require("luasnip.extras.fmt").fmt
local ls_utils = require "jrasmusbm.snippets.utils.init"
local i = ls.insert_node

local s = function(context, nodes, options)
  return function()
    return ls.s(context, nodes, options)
  end
end

return {
  s(
    { trig = "ir", name = "import react" },
    fmt(
      [[
import * as React from "react";
{}
  ]],
      { i(0) }
    )
  ),

  s(
    { trig = "rr", name = "reducer" },
    fmt(
      [[
const reducer = (state, action) => {{
  switch (action.type) {{
    case {}:
      return produce(state, draftState => {{
        {}
      }})
    {}
    default:
      return state
  }}
}}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "ra", name = "action" },
    fmt(
      [[
case {}:
  return produce(state, draftState => {{
    {}
  }})
{}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "hh", name = "generic hook" },
    fmt(
      [[
const {} = use{}({});
{}
]],
      { i(1), i(2), i(3), i(0) }
    )
  ),

  s(
    { trig = "he", name = "useEffect hook" },
    fmt("useEffect(() => {{\n  {}\n}}, [{}])\n\n{}", { i(1), i(2), i(0) })
  ),

  s(
    { trig = "hs", name = "useState hook" },
    fmt(
      [[
const [{}, set{}] = React.useState({});
{}
]],
      { i(1), ls_utils.capitalize(2, 1), i(3), i(0) }
    )
  ),

  s(
    { trig = "hr", name = "useReducer hook" },
    fmt(
      [[
const [{{ {} }}, dispatch] = React.useReducer(reducer, {{ {} }});
{}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "he", name = "useEffect hook" },
    fmt(
      [[
React.useEffect(() => {{
  {}
}}, [{}]);

{}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "hl", name = "useLayoutEffect hook" },
    fmt(
      [[
React.useLayoutEffect(() => {{
  {}
}}, [{}]);

{}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "hc", name = "useCallback hook" },
    fmt(
      [[
const {} = React.useCallback(({}) => {{
  {}
}}, [{}]);

{}
]],
      { i(1), i(2), i(3), i(4), i(0) }
    )
  ),

  s(
    { trig = "hm", name = "useMemo" },
    fmt(
      [[
const {} = React.useMemo(({}) => {{
  {}
}}, [{}]);

{}
]],
      { i(1), i(2), i(3), i(4), i(0) }
    )
  ),
}
