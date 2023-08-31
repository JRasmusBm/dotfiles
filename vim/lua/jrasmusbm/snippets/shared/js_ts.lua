require("plenary.reload").reload_module "jrasmusbm.snippets.utils.init"

local ls = require "luasnip"
local fmt = require("luasnip.extras.fmt").fmt
local ls_utils = require "jrasmusbm.snippets.utils.init"
local i = ls.insert_node
local d = ls.dynamic_node
local t = ls.text_node
local rep = require("luasnip.extras").rep

local s = function(context, nodes, options)
  return function()
    return ls.s(context, nodes, options)
  end
end

return {
  s(
    { trig = "id", name = "import default" },
    fmt('import {} from "{}"\n{}', { i(2), i(1), i(0) })
  ),
  s(
    { trig = "ia", name = "import all" },
    fmt('import * as {} from "{}"\n{}', { i(2), i(1), i(0) })
  ),
  s(
    { trig = "in", name = "import named" },
    fmt('import {{ {} }} from "{}"\n{}', { i(2), i(1), i(0) })
  ),
  s(
    { trig = "im", name = "import module" },
    fmt('import "{}"\n{}', { i(1), i(0) })
  ),

  s(
    { trig = "en", name = "export named" },
    fmt("export {{\n  {}\n}}", { i(0) })
  ),
  s(
    { trig = "ed", name = "export default" },
    fmt("export default {}", { i(0) })
  ),

  s(
    { trig = "el", name = "event listener" },
    fmt('{}.eventListener("{}", {})\n{}', { i(1), i(2), i(3), i(0) })
  ),
  s(
    { trig = "ef", name = "fire event" },
    fmt(
      '{}.dispatchEvent(new Event("{}", {{\n  {}\n}}))\n{}',
      { i(1), i(2), i(3), i(0) }
    )
  ),

  s({ trig = "wf", name = "witchcraft file" }, {
    t { '// @include "./utils/addAttributes.js"', "" },
    t { "", "" },
    t { "(function main() {{", "\t" },
    t { "(setInterval(() => {{", "\t\t" },
    i(0),
    t { "", "\t" },
    t { "}}, 1000)", "" },
    t { ")()" },
  }),
  s(
    { trig = "wb", name = "witchcraft button" },
    fmt(
      'addAttributes({{\n  query: "{}",\n  attributes: {{ role: "button" }},\n}})\n{}',
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "of", name = "object field" },
    fmt("{}: {}{},\n{}", { i(1), i(2), rep(1), i(0) })
  ),

  s(
    { trig = "lf", name = "format string" },
    fmt("JSON.stringify({}, null, 2){}", { i(1), i(0) })
  ),
  s({ trig = "ll", name = "log" }, fmt("console.log({})\n{}", { i(1), i(0) })),
  s(
    { trig = "le", name = "log error" },
    fmt("console.error({})\n{}", { i(1), i(0) })
  ),
  s(
    { trig = "lc", name = "log count" },
    fmt(
      [[
console.count({})
{}
  ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "lg", name = "log group" },
    fmt(
      [[
console.group({})
{}
console.groupEnd()
  ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "li", name = "log info" },
    fmt("console.info({})\n{}", { i(1), i(0) })
  ),
  s(
    { trig = "lt", name = "log table" },
    fmt("console.table({}, [{}])", { i(1), i(0) })
  ),

  s(
    { trig = "lb", name = "log breakpoint" },
    fmt(
      [[
console.dir({{
  tag: "{}",
  {},
}}, {{ depth: 20 }})
  ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "doc", name = "jsdoc" },
    fmt(
      [[
/**
 * {}
 */
  ]],
      { i(0) }
    )
  ),

  s(
    { trig = "vl", name = "let" },
    fmt("let {} = {}\n{}", { i(1), i(2), i(0) })
  ),
  s(
    { trig = "vc", name = "const" },
    fmt("const {} = {}\n{}", { i(1), i(2), i(0) })
  ),
  s(
    { trig = "vd", name = "destructure" },
    fmt("const {{ {} }} = {}\n{}", { i(1), i(2), i(0) })
  ),

  s(
    { trig = "fi", name = "inline function" },
    fmt("({}) => {}", { i(1), i(0) })
  ),
  s(
    { trig = "fd", name = "function definition" },
    fmt(
      "function {}({}) {{\n  return ({})\n}}\n\n{}",
      { i(1), i(2), i(3, "null"), i(0) }
    )
  ),
  s(
    { trig = "fa", name = "arrow function" },
    fmt(
      "const {} = ({}) => {{\n  return ({})\n}}\n\n{}",
      { i(1), i(2), i(3, "null"), i(0) }
    )
  ),

  s(
    { trig = "st", name = "set timeout" },
    fmt(
      "setTimeout(() => {{\n  {}\n}}, {})\n\n{}",
      { i(1), i(2, "1000"), i(0) }
    )
  ),
  s(
    { trig = "si", name = "set interval" },
    fmt(
      "setInterval(() => {{\n  {}\n}}, {})\n\n{}",
      { i(1), i(2, "1000"), i(0) }
    )
  ),

  s(
    { trig = "qt", name = "gql tag" },
    fmt("const {} = gql```\n{}\n```\n\n{}", { i(1), i(2), i(0) })
  ),
  s(
    { trig = "qr", name = "graphql resolver" },
    fmt("const {} = async ({}, {}, {}, {}) => {{\n  return ({})\n}}", {
      i(1),
      i(2, "_parent"),
      i(3, "_args"),
      i(4, "_context"),
      i(5, "_info"),
      i(0, "null"),
    })
  ),

  s(
    { trig = "ci", name = "if statement" },
    fmt("if ({}) {{\n  {}\n}}\n\n{}", { i(1), i(2), i(0) })
  ),
  s(
    { trig = "cei", name = "else if statement" },
    fmt("else if ({}) {{\n  {}\n}}\n\n{}", { i(1), i(2), i(0) })
  ),
  s(
    { trig = "ce", name = "else statement" },
    fmt("else {{\n  {}\n}}\n\n{}", { i(1), i(0) })
  ),
  s(
    { trig = "cw", name = "while statement" },
    fmt("if ({}) {{\n  {}\n}}\n\n{}", { i(1), i(2), i(0) })
  ),
  s(
    { trig = "ct", name = "try / catch" },
    fmt(
      "try {{\n  {}\n}} catch {}{{\n  {}\n}}\n\n{}",
      { i(1), i(2), i(3), i(0) }
    )
  ),
  s(
    { trig = "cs", name = "switch statement" },
    fmt(
      "switch ({}) {{\n  case {}: {{\n    {}\n    break\n  }}\n  {}\n}}\n{}",
      { i(1), i(2), i(3), i(4), i(0) }
    )
  ),
  s(
    { trig = "cc", name = "switch case" },
    fmt("case {}: {{\n  {}\n  break\n}}\n{}", { i(1), i(2), i(0) })
  ),
  s(
    { trig = "cd", name = "default case" },
    fmt("default: {{\n  {}\n}}", { i(0) })
  ),
  s(
    { trig = "cf", name = "for each" },
    fmt("for (const {} of {}) {{\n  {}\n}}\n\n{}", { i(1), i(2), i(3), i(0) })
  ),
  s(
    { trig = "cfr", name = "for range" },
    fmt(
      "for (let {} = {}; {} < {}; {}{}) {{\n  {}\n}}\n\n{}",
      { i(1), i(2, "0"), rep(1), i(3), rep(1), i(4, "++"), i(5), i(0) }
    )
  ),

  s(
    { trig = "et", name = "ternary expression" },
    fmt("{} ? ({}): ({}){}", { i(1), i(2), i(3), i(0) })
  ),

  s(
    { trig = "em", name = "map expression" },
    fmt(
      [[
{}.map(({}) => ({}))
  ]],
      { i(1), i(2), i(3) }
    )
  ),

  s(
    { trig = "tc", name = "type class" },
    fmt("class {} {{\n  {}\n}}\n\n{}", { i(1), i(2), i(0) })
  ),

  s(
    { trig = "jq", name = "jquery" },
    fmt("$({}).{}\n\n{}", { i(1), i(2), i(0) })
  ),
  s(
    { trig = "ij", name = "import jquery" },
    fmt('import $ from "jquery"\n{}', { i(0) })
  ),

  s(
    { trig = "an", name = "named argument" },
    fmt("{} = {}{},\n{}", { i(1), i(2), rep(1), i(0) })
  ),

  s(
    { trig = "d3u", name = "d3 update" },
    fmt(
      [[
function update(data) {{
  // Update scales (if dependent on the data)
  {}

  // Join updated data to elements
  {}

  // Remove unwanted shapes (using the exit selection)
  {}

  // Update existing shapes in the DOM
  {}

  // Append the enter selection to the DOM
  {}
}}
  ]],
      { i(1), i(2), i(3), i(4), i(0) }
    )
  ),

  s(
    { trig = "d3t", name = "d3 tween" },
    fmt(
      [[
function {}(_d: unknown) {{
  const i = d3.interpolate(0, x.bandwidth());

  return function tick(t: number) {{
    return i(t);
  }};
}}
  ]],
      { i(0) }
    )
  ),

  s(
    { trig = "lbb", name = "log breakpoint" },
    fmt(
      [[
console.log("{}", JSON.stringify({{
  {}
}}, null, 2))
  ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "lp", name = "log performance" },
    fmt(
      [[
console.log(`- {}: ${{performance.now()}}`);
  ]],
      { i(0) }
    )
  ),
}
