require("plenary.reload").reload_module "jrasmusbm.snippets.utils.init"

local ls = require "luasnip"
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node

require("jrasmusbm.treesitter.parent").setup_parent_mappings({
  "function_definition",
}, { { "name" } })

local s = function(context, nodes, options)
  return function()
    return ls.s(context, nodes, options)
  end
end

return {
  s(
    { trig = "cf", name = "for each" },
    fmt(
      [[
for {} in {} ; do
  (
    {}
  )
done

{}
 ]],
      { i(1), i(2), i(3), i(0) }
    )
  ),

  s(
    { trig = "cfr", name = "for range" },
    fmt(
      "for {} in {{{}..{}}} ; do\n  {}\ndone\n\n{}",
      { i(1, "i"), i(2, "0"), i(3), i(4), i(0) }
    )
  ),
  s(
    { trig = "cfr", name = "for range" },
    fmt(
      [[
for i in {{0..{}}} ; do
  (
    {}
  )
done

{}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "ci", name = "if statement" },
    fmt(
      [[
if {} ; then
  (
    {}
  )
fi

{}
]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "ce", name = "else statement" },
    fmt(
      [[
else
  (
    {}
  )
]],
      { i(0) }
    )
  ),

  s(
    { trig = "ci", name = "if statement" },
    fmt(
      [[
elif {} ; then
  (
    {}
  )
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "fd", name = "function definition" },
    fmt(
      [[
{}() {{
  (
    {}
  )
}}

{}
  ]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "ts", name = "tmux session" },
    fmt(
      'tmux new-session -d -s {} -n {} -x "$(tput cols)" -y "$(tput lines)"\n\n{}',
      { i(1), i(2), i(0) }
    )
  ),
  s(
    { trig = "tw", name = "tmux window" },
    fmt('tmux new-window -t "$session_name" -n {}\n{}', { i(1), i(0) })
  ),
  s(
    { trig = "tc", name = "tmux command" },
    fmt('tmux send-keys -t "$session_name" "{}" Enter\n{}', { i(1), i(0) })
  ),
  s(
    { trig = "tcp", name = "(python) venv tmux command" },
    fmt('tmux send-keys -t "$session_name" "ac" Enter\n{}', { i(0) })
  ),
  s(
    { trig = "tcn", name = "(node) nvm tmux command" },
    fmt(
      'tmux send-keys -t "$session_name" "nvm use --latest-npm {}" Enter\n{}',
      { i(1, "16"), i(0) }
    )
  ),
  s(
    { trig = "tv", name = "tmux vertical split" },
    fmt('tmux split-window -t "$session_name" -h\n{}', { i(0) })
  ),
  s(
    { trig = "th", name = "tmux horizontal split" },
    fmt('tmux split-window -t "$session_name" \n{}', { i(0) })
  ),
  s(
    { trig = "ti", name = "import tmux script" },
    fmt("INITIATED_EXTERNALLY=true source_tmux_script {}\n{}", { i(1), i(0) })
  ),
  s(
    { trig = "ta", name = "tmux attach" },
    fmt("tmux-attach-to-session -t {}\n{}", { i(1), i(0) })
  ),

  s(
    { trig = "hc", name = "handle ctrl-c" },
    fmt("trap_ctrlc() {{\n  {}\n  exit 2\n}}\n\ntrap 'trap_ctrlc' 2", { i(0) })
  ),

  s(
    { trig = "as", name = "alias" },
    fmt('alias "{}"="{}"\n{}', { i(1), i(2), i(0) })
  ),

  s(
    { trig = "lb", name = "log breakpoint" },
    fmt(
      [[
echo "$0: {}"
]],
      { i(0) }
    )
  ),
}
