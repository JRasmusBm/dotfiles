local ls = require "luasnip"

local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local rep = require("luasnip.extras").rep

ls.add_snippets("all", {
  s(
    { trig = "!sh", name = "shell script" },
    fmt(
      [[
#!/bin/sh

set -e

_{}() {{
    {}
}}

_{} "$@"
    ]],
      { i(1), i(0), rep(1) }
    )
  ),

  s(
    { trig = "!bash", name = "bash script" },
    fmt(
      [[
#!/bin/bash

set -e

_{}() {{
    {}
}}

_{} "$@"
    ]],
      { i(1), i(0), rep(1) }
    )
  ),

  s(
    { trig = "!tmux", name = "tmux file" },
    fmt(
      [[
#!/bin/bash

set -e

folder_path="/home/jrasmusbm/dotfiles"
session_name="$(tmux-session-name-from-path "$folder_path")"

cd "$folder_path"

if ! tmux has-session -t="$session_name" 2> /dev/null ; then
  tmux new-session -d -s "$session_name" -n run -x "$(tput cols)" -y "$(tput lines)"

  {}  

  tmux new-window -t "$session_name" -n vim
  tmux send-keys -t "$session_name" "vim -c GFiles" Enter

  tmux new-window -t "$session_name" -n cli
  tmux send-keys -t "$session_name" "g ll" Enter
  tmux send-keys -t "$session_name" "g" Enter
fi

if test ! "$INITIATED_EXTERNALLY" = 'true' ; then
  tmux-attach-to-session "$session_name:vim"
fi
  ]],
      { i(0) }
    )
  ),

})
