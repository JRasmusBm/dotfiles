require("plenary.reload").reload_module "jrasmusbm.snippets.utils.init"

local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local rep = require("luasnip.extras").rep
local ls_utils = require "jrasmusbm.snippets.utils"

ls.add_snippets("tsx", {
  s(
    { trig = "rf", name = "react file" },
    fmt(
      "type {}Props = {{\n  {}\n}}\n\nconst {} = ({{{}}}: {}Props) => {{\n  return ({})\n}}\n\nexport default {}",
      { rep(1), i(2), i(1), i(3), rep(1), i(0, "null"), rep(1) }
    )
  ),
  s(
    { trig = "rc", name = "react component" },
    fmt(
      "type {}Props = {{\n  {}\n}}\n\nconst {} = ({{{}}}: {}Props) => {{\n  return ({})\n}}",
      { rep(1), i(2), i(1), i(3), rep(1), i(0, "null") }
    )
  ),

  s(
    { trig = "debugp", name = "debug props" },
    fmt(
      [[
function logPropDifferences(newProps: any, lastProps: any) {{
  const allKeys = new Set([
    ...Object.keys(newProps),
    ...Object.keys(lastProps),
  ]);

  console.log("======= RENDER ========")
  allKeys.forEach((key) => {{
    const newValue = newProps[key];
    const lastValue = lastProps[key];
    if (newValue !== lastValue) {{
      console.log(`New Value (${{key}}): `, newValue);
      console.log(`Last Value (${{key}}): `, lastValue);
    }}
  }});
}}

function useDebugPropChanges(newProps: any) {{
  const lastProps = useRef();
  // Should only run when the component re-mounts
  useEffect(() => {{
    console.log("Mounted");
  }}, []);
  if (lastProps.current) {{
    logPropDifferences(newProps, lastProps.current);
  }}
  lastProps.current = newProps;
}}

{}
  ]],
      { i(0) }
    )
  ),
})

ls_utils.load_shared { filetype = "tsx", shared = "html" }
ls_utils.load_shared { filetype = "tsx", shared = "css" }
ls_utils.load_shared { filetype = "tsx", shared = "graphql" }
ls_utils.load_shared { filetype = "tsx", shared = "react" }
