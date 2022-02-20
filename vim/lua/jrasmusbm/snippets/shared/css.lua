local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local t = ls.text_node

local s = function(context, nodes, options)
  return function() return ls.s(context, nodes, options) end
end

return {
  s({trig = "ssf", name = "css file"}, {
    t {"* { box-sizing: border-box }", ""},
    t {"", ""},
    t {"html, body {", "\t"},
    t {"padding: 0;", "\t"},
    t {"margin: 0;", ""},
    t {"}"},
    t {"", ""},
    t {"", ""},
    i(0)
  }),

  s({trig = "sr", name = "style rule"}, fmt("{} {{\n  {}\n}}\n\n{}", {
    i(1),
    i(2, "background-color: orange !important;"),
    i(0),
  })),
  s({trig = "sa", name = "style attribute"},
    fmt("{}: {};\n{}", {i(1), i(2), i(0)})),

  s({trig = "sw", name = "width"}, fmt("width: {};\n{}", {i(1), i(0)})),
  s({trig = "sh", name = "height"}, fmt("height: {};\n{}", {i(1), i(0)})),
  s({trig = "sb", name = "background"}, fmt("background: {};\n{}", {i(1), i(0)})),
  s({trig = "sc", name = "color"}, fmt("color: {};\n{}", {i(1), i(0)})),
  s({trig = "sd", name = "display"}, fmt("display: {};\n{}", {i(1), i(0)})),
  s({trig = "sdb", name = "display block"}, fmt("display: block;\n{}", {i(0)})),
  s({trig = "sdf", name = "display flex"}, fmt("display: flex;\n{}", {i(0)})),
  s({trig = "sdg", name = "display grid"}, fmt("display: grid;\n{}", {i(0)})),

  s({trig = "smw", name = "min-width"}, fmt("min-width: {};\n{}", {i(1), i(0)})),
  s({trig = "smm", name = "min-height"},
    fmt("min-height: {};\n{}", {i(1), i(0)})),

  s({trig = "sfg", name = "flex-grow"}, fmt("flex-grow: {};\n{}", {i(1), i(0)})),
  s({trig = "sfd", name = "flex-direction"},
    fmt("flex-direction: {};\n{}", {i(1), i(0)})),

  s({trig = "sfs", name = "font-size"}, fmt("font-size: {};\n{}", {i(1), i(0)})),
  s({trig = "sff", name = "font-family"},
    fmt("font-family: {};\n{}", {i(1), i(0)})),
  s({trig = "sfw", name = "font-weight"},
    fmt("font-weight: {};\n{}", {i(1), i(0)})),

  s({trig = "sjs", name = "justify-self"},
    fmt("justify-self: {};\n{}", {i(1), i(0)})),
  s({trig = "sjc", name = "justify-content"},
    fmt("justify-content: {};\n{}", {i(1), i(0)})),

  s({trig = "sai", name = "align-items"},
    fmt("align-items: {};\n{}", {i(1), i(0)})),
  s({trig = "sas", name = "align-self"},
    fmt("align-self: {};\n{}", {i(1), i(0)})),

  s({trig = "spo", name = "position"}, fmt("position: {};\n{}", {i(1), i(0)})),

  s({trig = "sbr", name = "border-radius"},
    fmt("border-radius: {};\n{}", {i(1), i(0)})),
  s({trig = "sb", name = "border"}, fmt("border: {};\n{}", {i(1), i(0)})),

  s({trig = "spd", name = "padding"}, fmt("padding: {};\n{}", {i(1), i(0)})),
  s({trig = "spt", name = "padding-top"},
    fmt("padding-top: {};\n{}", {i(1), i(0)})),
  s({trig = "spr", name = "padding-right"},
    fmt("padding-right: {};\n{}", {i(1), i(0)})),
  s({trig = "spl", name = "padding-left"},
    fmt("padding-left: {};\n{}", {i(1), i(0)})),
  s({trig = "spb", name = "padding-bottom"},
    fmt("padding-bottom: {};\n{}", {i(1), i(0)})),

  s({trig = "smg", name = "margin"}, fmt("margin: {};\n{}", {i(1), i(0)})),
  s({trig = "spt", name = "margin-top"},
    fmt("margin-top: {};\n{}", {i(1), i(0)})),
  s({trig = "spr", name = "margin-right"},
    fmt("margin-right: {};\n{}", {i(1), i(0)})),
  s({trig = "spl", name = "margin-left"},
    fmt("margin-left: {};\n{}", {i(1), i(0)})),
  s({trig = "spb", name = "margin-bottom"},
    fmt("margin-bottom: {};\n{}", {i(1), i(0)})),

  s({trig = "stc", name = "grid-template-columns"},
    fmt("grid-template-columns: {};\n{}", {i(1), i(0)})),
  s({trig = "str", name = "grid-template-rows"},
    fmt("grid-template-rows: {};\n{}", {i(1), i(0)})),

  s({trig = "sgr", name = "grid-row"}, fmt("grid-row: {};\n{}", {i(1), i(0)})),
  s({trig = "sgc", name = "grid-column"},
    fmt("grid-column: {};\n{}", {i(1), i(0)})),
  s({trig = "sgg", name = "grid-gap"}, fmt("grid-gap: {};\n{}", {i(1), i(0)})),
  s({trig = "sar", name = "grid-auto-row"},
    fmt("grid-auto-row: {};\n{}", {i(1), i(0)})),

  s({trig = "so", name = "overflow"}, fmt("overflow: {};\n{}", {i(1), i(0)})),
  s({trig = "soh", name = "overflow hidden"},
    fmt("overflow: hidden;\n{}", {i(0)})),

  s({trig = "smq", name = "media query"},
    fmt("@media ({}) {{\n  {}\n}}", {i(1), i(0)})),

  s({ trig="sz", name="z-index" }, fmt("z-index: {}\n{}", { i(1), i(0) })),
  s({ trig="scu", name="cursor" }, fmt("cursor: {}\n{}", { i(1), i(0) })),
  s({ trig="sop", name="opacity" }, fmt("opacity: {}\n{}", { i(1), i(0) })),
  s({ trig="sbs", name="box-shadow" }, fmt("box-shadow: {}\n{}", { i(1), i(0) })),
  
}
