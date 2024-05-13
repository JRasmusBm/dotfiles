require("plenary").reload.reload_module "jrasmusbm.snippets.utils.init"

local ls = require "luasnip"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local d = ls.dynamic_node
local rep = require("luasnip.extras").rep
local ls_utils = require "jrasmusbm.snippets.utils"

require("jrasmusbm.matchit").load_html_pairs()

vim.api.nvim_create_user_command("DebugClear", function()
  vim.cmd [[
norm 0gg/logPropDifferencesdafndaf/useDebugdd?propsT}D%d0da{;ao/props:viwp==:w
  ]]
end, { nargs = "*" })

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
function logPropDifferences(
  newProps: Record<string, any>,
  lastProps: Record<string, any>
  ) {{
    const allKeys = new Set([
    ...Object.keys(newProps),
    ...Object.keys(lastProps),
    ]);

    allKeys.forEach((key) => {{
      const newValue = newProps[key];
      const lastValue = lastProps?.[key];
      if (newValue !== lastValue) {{
        console.log(`New Value (${{key}}): `, newValue);
        console.log(`Last Value (${{key}}): `, lastValue);
      }}
    }});
  }}

function useDebugPropChanges(newProps: Record<string, any>) {{
  const lastProps = useRef<Record<string, any>>();
  const counters = useMemo(() => {{
    return {{ count: 0 }};
  }}, []);

  console.log(`======= RENDER {} ${{counters.count++}} ========`);

  if (lastProps.current) {{
    logPropDifferences(newProps, lastProps.current);
  }}

  lastProps.current = newProps;
}}

const {} = props
useDebugPropChanges(props)
]],
      { d(1, ls_utils.basename, {}), i(0) }
    )
  ),

  s(
    { trig = "rconf", name = "react context file" },
    fmt(
      [[
import {{ createContext, useContext }} from "react";

type {}ContextType = {{
  {}
}};

const {}Context = createContext<{}ContextType>(null as any);

const useProvide{} = (): {}ContextType => {{
  return {{}};
}};

export const Provide{} = ({{ children }}: any) => {{
  const value = useProvide{}();

  return (
    <{}Context.Provider value={{value}}>
      {{children}}
    </{}Context.Provider>
  );
}};

export const use{} = () => {{
  return useContext({}Context);
}};
  ]],
      {
        i(1),
        i(0),
        rep(1),
        rep(1),
        rep(1),
        rep(1),
        rep(1),
        rep(1),
        rep(1),
        rep(1),
        rep(1),
        rep(1),
      }
    )
  ),
})

ls_utils.load_shared { filetype = "tsx", shared = "html" }
ls_utils.load_shared { filetype = "tsx", shared = "css" }
ls_utils.load_shared { filetype = "tsx", shared = "graphql" }
ls_utils.load_shared { filetype = "tsx", shared = "react" }
