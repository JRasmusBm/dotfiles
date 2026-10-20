---
name: second-account
description: Set up my second Claude login in cswap with the same connectors as my main one — 'set me up', 'set up this account', 'connect my connectors', 'second account'. Drives OAuth for each connector; I click consent.
---

# Second account setup

Accounts are managed by `cswap` (claude-swap, `pipx install
claude-swap`). Both share `~/.claude` (settings, skills, memory,
history, local MCP servers); cswap swaps only the login.
`cswap list` shows each account's 5h/7d usage; `cswap auto`
switches before a limit. `cswap run <n>` runs one terminal as
account `n` without touching the default.

## Steps

1. `cswap list`. If the second account is missing: tell me to run
   `/login` in a Claude session with it, then `cswap add --alias
   second`. Stop until that's done.
2. Switch to it (`cswap switch second`), restart this session, and
   confirm with `/status`.
3. Check local MCP servers connect (`claude mcp list`); for
   ones needing auth (linear-server), start the flow and
   hand me the link.
4. claude.ai connectors — target set (connected on main
   account as of 2026-10-08):
   - Slack, Notion, HubSpot
   - Pylon, Polar Analytics, OpenRAG, Aurora (org-added,
     log in with Polar Google account)
   - Gmail, Google Calendar — with the **second** Google
     account (main account had these unauthenticated)
   claude.ai connectors can't be authed from a tool call:
   list the ones present as `mcp__claude_ai_<Name>__authenticate`
   and have me run `/mcp` → pick each. Then verify.
5. Connectors missing entirely (no tools at all) must be
   added on claude.ai → Settings → Connectors. List them for
   me; custom ones need a URL (fill in below once known).
6. Report: table of connector → connected / needs me. Then
   `cswap switch main` unless I said otherwise.
