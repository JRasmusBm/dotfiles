---
name: second-account
description: Set up my second Claude login (the `claude2` profile) with the same connectors as my main one — 'set me up', 'set up this account', 'connect my connectors', 'second account'. Drives OAuth for each connector; I click consent.
---

# Second account setup

Main login runs from `~/.claude`; the second from `~/.claude-2`
via `alias claude2="CLAUDE_CONFIG_DIR=$HOME/.claude-2 claude"`
(`shell/zshenv`). Settings, skills, statusline symlinked via
`files.csv`. `~/.claude-2/.claude.json` was seeded with the
local MCP servers: `chrome-devtools`, `polar-mcp` (global),
`linear-server` (ice-floe project).

## Steps

1. Confirm which account is logged in (`/status`). If it's the
   main one, stop — tell me to run `claude2` and `/login`.
2. Check local MCP servers connect (`claude mcp list`); for
   ones needing auth (linear-server), start the flow and
   hand me the link.
3. claude.ai connectors — target set (connected on main
   account as of 2026-10-08):
   - Slack, Notion, HubSpot
   - Pylon, Polar Analytics, OpenRAG, Aurora (org-added,
     log in with Polar Google account)
   - Gmail, Google Calendar — with the **second** Google
     account (main account had these unauthenticated)
   claude.ai connectors can't be authed from a tool call:
   list the ones present as `mcp__claude_ai_<Name>__authenticate`
   and have me run `/mcp` → pick each. Then verify.
4. Connectors missing entirely (no tools at all) must be
   added on claude.ai → Settings → Connectors. List them for
   me; custom ones need a URL (fill in below once known).
5. Report: table of connector → connected / needs me.

## Not carried over

Auto memory (`~/.claude/projects/*/memory`) and history stay
with the main profile.
