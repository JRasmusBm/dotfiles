local ls = require "luasnip"

local ls_utils = require "jrasmusbm.snippets.utils"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local d = ls.dynamic_node
local rep = require("luasnip.extras").rep

ls.add_snippets("all", {
  s(
    { trig = "!sh", name = "shell script" },
    fmt(
      [[
#!/bin/sh

set -e

_{}() {{
  (
    {}
  )
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
  (
    {}
  )
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

folder_path="{}"
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
  (
    tmux-attach-to-session "$session_name:vim"
  )
fi

cd -
  ]],
      { d(1, ls_utils.file_name, {}), i(0) }
    )
  ),

  s(
    { trig = "!tex", name = "latex file" },
    fmt(
      [[
\documentclass{{article}}

\usepackage[utf8]{{inputenc}}

\title{{{}}}
\date{{\today}}

\author{{{}~\thanks{{{}}}}}

\begin{{document}}

\maketitle{{}}

\newpage{{}}

{}

\end{{document}}
]],
      { i(1), i(2), i(3), i(0) }
    )
  ),

  s(
    { trig = "!texmod", name = "latex module" },
    fmt(
      [[
% !TEX root = .{}/main.tex
%
{}
]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "!gop", name = "go package" },
    fmt("package {}\n\n{}", { i(1), i(0) })
  ),

  s(
    { trig = "!lua", name = "lua file" },
    fmt("local M = {{}}\n\n{}\n\nreturn M{}", { i(1), i(0) })
  ),

  s(
    { trig = "!py", name = "python (script) file" },
    fmt(
      [[
#!/bin/env python3.10

import argparse
import subprocess

def run_shell(cmd) -> str:
    return subprocess.run(cmd, capture_output=True).stdout.decode("utf-8").strip()

def main():
    parser = argparse.ArgumentParser(description="{}")

    parser.add_argument("file", type=str, nargs="?", default="-")

    args = parser.parse_args()

    if not args.file or args.file == "-":
        contents = sys.stdin.readlines()
    else:
        with open(args.file) as f:
            contents = f.readlines()

    {}

if __name__ == "__main__":
    main()
  ]],
      { i(1), i(0) }
    )
  ),
})
