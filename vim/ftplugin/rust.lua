local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node

ls.add_snippets("rust", {
  s(
    { trig = "tc", name = "struct (class)" },
    fmt(
      [[
struct {} {{
    {}
}}

{}
  ]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "ti", name = "trait (interface)" },
    fmt(
      [[
trait {} {{
    fn {}(&self{}) -> {};
}}

{}
  ]],
      { i(1), i(2), i(3), i(4), i(0) }
    )
  ),

  s(
    { trig = "tp", name = "impl (aPplication)" },
    fmt(
      [[
impl {} for {} {{
}}

{}
  ]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "tm", name = "method" },
    fmt(
      [[
fn {}(&self{}) -> {{
  {}
}}

{}
  ]],
      { i(1), i(2), i(3), i(0) }
    )
  ),

  s(
    { trig = "vm", name = "mutable varable" },
    fmt(
      [[
let mut {} = {};
{}
  ]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "vc", name = "constant" },
    fmt(
      [[
let {} = {};
{}
  ]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "ll", name = "print" },
    fmt(
      [[
println!({});
{}
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "im", name = "import module" },
    fmt(
      [[
use {};
{}
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "fd", name = "function definition" },
    fmt(
      [[
fn {}({}) {{
    {}
}}

{}
]],
      { i(1), i(2), i(3), i(0) }
    )
  ),

  s(
    { trig = "ci", name = "if statement" },
    fmt(
      [[
if {} {{
    {}
}}

{}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "cw", name = "while loop" },
    fmt(
      [[
while {} {{
    {}
}}

{}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "cl", name = "loop" },
    fmt(
      [[
loop {{
    {}
}}

{}
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "cm", name = "match statement" },
    fmt(
      [[
match {} {{
    {} => {},
    {}
}}

{}
]],
      { i(1), i(2), i(3), i(4), i(0) }
    )
  ),

  s(
    { trig = "cc", name = "match case" },
    fmt(
      [[
{} => {},
{}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "ds", name = "test suite" },
    fmt(
      [[
#[cfg(test)]
mod test {{
    use super::*;

    #[test]
    fn {}() {{
        {}
    }}

    {}
}}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "dc", name = "test case" },
    fmt(
      [[
#[test]
fn {}() {{
    {}
}}

{}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "de", name = "test assert" },
    fmt(
      [[
assert{}({});
{}
]],
      { i(1), i(2), i(0) }
    )
  ),
})
