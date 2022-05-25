require("plenary.reload").reload_module "jrasmusbm.snippets.utils.init"

local ls = require "luasnip"
local fmt = require("luasnip.extras.fmt").fmt
local ls_utils = require "jrasmusbm.snippets.utils.init"
local i = ls.insert_node
local d = ls.dynamic_node
local t = ls.text_node

local s = function(context, nodes, options)
  return function()
    return ls.s(context, nodes, options)
  end
end

return {
  s(
    { trig = "cf", name = "for each" },
    fmt("for {} in {} ; do\n  {}\ndone\n\n{}", { i(1), i(2), i(3), i(0) })
  ),
  s(
    { trig = "cfr", name = "for range" },
    fmt(
      "for {} in {{{}..{}}} ; do\n  {}\ndone\n\n{}",
      { i(1, "i"), i(2, "0"), i(3), i(4), i(0) }
    )
  ),
  s(
    { trig = "ci", name = "if statement" },
    fmt("if {} ; then\n  {}\nfi\n\n{}", { i(1), i(2), i(0) })
  ),
  s({ trig = "ce", name = "else statement" }, fmt("else\n  {}", { i(0) })),
  s(
    { trig = "cei", name = "elif clause" },
    fmt("elif {} ; then\n  {}\n{}", { i(1), i(2), i(0) })
  ),

  s(
    { trig = "sf", name = "script file" },
    {
      t { "#!/bin/sh", "" },
      t { "", "" },
      t { "set -e", "" },
      t { "", "" },
      i(0),
    }
  ),

  s(
    { trig = "fd", name = "function definition" },
    fmt("{}() {{\n  {}\n}}\n\n{}", { i(1), i(2), i(0) })
  ),

  s({ trig = "tf", name = "tmux file" }, {
    t { "#!/bin/bash", "" },
    t { "", "" },
    t { "set -e", "" },
    t { "", "" },
    t { 'folder_path="' },
    d(1, ls_utils.file_name, {}),
    t { '"', "" },
    t { 'session_name="$(tmux-session-name-from-path "$folder_path")"', "" },
    t { "", "" },
    t { 'cd "$folder_path"', "" },
    t { "", "" },
    t { 'if ! tmux has-session -t="$session_name" 2> /dev/null ; then', "\t" },
    t {
      'tmux new-session -d -s "$session_name" -n run -x "$(tput cols)" -y "$(tput lines)"',
      "",
    },
    t { "", "\t" },
    i(2),
    t { "", "" },
    t { "", "\t" },
    t { "tmux new-window -n vim", "\t" },
    t { 'tmux send-keys -t vim "vim -c GFiles" Enter', "" },
    t { "", "\t" },
    t { "tmux new-window -n cli", "\t" },
    t { 'tmux send-keys -t cli "g ll" Enter', "\t" },
    t { 'tmux send-keys -t cli "g" Enter', "" },
    t { "fi", "" },
    t { "", "" },
    t { "if test ! \"$INITIATED_EXTERNALLY\" = 'true' ; then", "\t" },
    t { 'tmux-attach-to-session "$session_name:vim"', "" },
    t { "fi" },
  }),
  s(
    { trig = "ts", name = "tmux session" },
    fmt(
      'tmux new-session -d -s {} -n {} -z "$(tput cols)" -y "$(tput lines)"\n\n{}',
      { i(1), i(2), i(0) }
    )
  ),
  s(
    { trig = "tw", name = "tmux window" },
    fmt("tmux new-window -n {}\n{}", { i(1), i(0) })
  ),
  s(
    { trig = "tc", name = "tmux command" },
    fmt('tmux send-keys -t {} "{}" Enter\n{}', { i(1), i(2), i(0) })
  ),
  s(
    { trig = "tv", name = "tmux vertical split" },
    fmt("tmux split-window -t {} -h\n{}", { i(1), i(0) })
  ),
  s(
    { trig = "th", name = "tmux horizontal split" },
    fmt("tmux split-window -t {}\n{}", { i(1), i(0) })
  ),
  s(
    { trig = "ti", name = "import tmux script" },
    fmt("INITIATED_EXTERNALLY=true source_tmux_script {}\n{}", { i(1), i(0) })
  ),
  s(
    { trig = "ta", name = "tmux attach" },
    fmt("tmux attach -t {}\n{}", { i(1), i(0) })
  ),

  s(
    { trig = "hc", name = "handle ctrl-c" },
    fmt("trap_ctrlc() {{\n  {}\n  exit 2\n}}\n\ntrap 'trap_ctrlc' 2", { i(0) })
  ),

  s(
    { trig = "as", name = "alias" },
    fmt('alias "{}"="{}"\n{}', { i(1), i(2), i(0) })
  ),
}
