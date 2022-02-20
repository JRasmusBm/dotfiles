local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local rep = require("luasnip.extras").rep

local s = function(context, nodes, options)
  return function() return ls.s(context, nodes, options) end
end

return {
  s({trig = "tc", name = "closed tag"}, fmt("<{} {} />\n{}", {i(1), i(2), i(0)})),
  s({trig = "to", name = "open tag"},
    fmt("<{} {}>\n  {}\n</{}>", {i(1), i(2), rep(1), i(0)})),

  s({trig = "th1", name = "h1 tag"},
    fmt("<h1 {}>\n  {}\n</h1>\n{}", {i(1), i(2), i(0)})),
  s({trig = "th2", name = "h2 tag"},
    fmt("<h2 {}>\n  {}\n</h2>\n{}", {i(1), i(2), i(0)})),
  s({trig = "th3", name = "h3 tag"},
    fmt("<h3 {}>\n  {}\n</h3>\n{}", {i(1), i(2), i(0)})),
  s({trig = "th4", name = "h4 tag"},
    fmt("<h4 {}>\n  {}\n</h4>\n{}", {i(1), i(2), i(0)})),
  s({trig = "th5", name = "h5 tag"},
    fmt("<h5 {}>\n  {}\n</h5>\n{}", {i(1), i(2), i(0)})),
  s({trig = "th6", name = "h6 tag"},
    fmt("<h6 {}>\n  {}\n</h6>\n{}", {i(1), i(2), i(0)})),

  s({trig = "td", name = "div tag"},
    fmt("<div {}>\n  {}\n</div>\n{}", {i(1), i(2), i(0)})),
  s({trig = "tp", name = "paragraph tag"},
    fmt("<p {}>\n  {}\n</p>\n{}", {i(1), i(2), i(0)})),
  s({trig = "ti", name = "image tag"},
    fmt("<img src=\"{}\" {}/>\n{}", {i(1), i(2), i(0)})),
  s({trig = "tbutton", name = "form submit"},
    fmt("<button type=\"{}\" {}>\n  {}\n</button>\n{}", {i(1), i(2), i(3), i(0)})),

  s({trig = "tbl", name = "bullet list tag"},
    fmt("<ul {}>\n  {}\n</ul>\n{}", {i(1), i(2), i(0)})),
  s({trig = "tbn", name = "bullet node tag"},
    fmt("<li {}>\n  {}\n</li>\n{}", {i(1), i(2), i(0)})),

  s({trig = "tnl", name = "numbered list tag"},
    fmt("<ol {}>\n  {}\n</ol>\n{}", {i(1), i(2), i(0)})),
  s({trig = "tnn", name = "bullet node tag"},
    fmt("<li {}>\n  {}\n</li>\n{}", {i(1), i(2), i(0)})),

  s({trig = "as", name = "string argument"},
    fmt("{}=\"{}\" {}", {i(1), i(2), i(0)})),
  s({trig = "aj", name = "interpolated (javascript) argument"},
    fmt("{}={{{}{}}} {}", {i(1), i(2), rep(1), i(0)})),

  s({ trig="ttf", name="HTML file" }, {
      t{"<!DOCTYPE html>", ""},
      t{"", ""},
      t{"<html>", "\t"},
      t{"<head>", "\t\t"},
      i(1)
      t{"", "\t"},
      t{"</head>", "\t"},
      t{"<body>", "\t\t"},
      i(2)
      t{"", "\t"},
      t{"</body>", "\t"},
      t{"</html>"},
    }),

  s({ trig="tis", name="import stylesheet" }, fmt("<link rel=\"stylesheet\" href=\"{}.css\" />\n{}", { i(1), i(0) })),
  s({ trig="tij", name="import javascript" }, fmt("<script type=\"module\" src=\"{}.js\"></script>\n{}", { i(1), i(0) })),
  s({ trig="tvp", name="set viewport" }, fmt("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" />\n{}", { i(0) })),

  s({trig = "tf", name = "form tag"},
    fmt("<form {}>\n  {}\n</form>\n{}", {i(1), i(2), i(0)})),
  s({trig = "tfs", name = "form submit"},
    fmt("<button type=\"submit\" {}>\n  {}\n</button>\n{}", {i(1), i(2), i(0)})),
  s({trig = "tfi", name = "form input"},
    fmt("<input type=\"{}\" {}>\n  {}\n</button>\n{}", {i(1), i(2), i(3), i(0)})),
  s({trig = "tfl", name = "form label"},
    fmt("<label>\n  <span>{}</span>\n  {}\n</label>\n{}", {i(1), i(2), i(0)})),
  s({trig = "tff", name = "form fieldset"},
    fmt("<fieldset>\n  <legend>{}</legend>\n  {}\n</fieldset>\n{}", {i(1), i(2), i(0)})),
  
}
