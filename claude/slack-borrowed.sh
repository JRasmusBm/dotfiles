#!/usr/bin/env bash
# PreToolUse hook for the claude.ai Slack connector's write tools. The
# connector acts as the active Claude login's Slack user, so on a
# borrowed login (someone else's, ~/.config/borrowed-logins, private
# overlay) a send would post, react or edit as that person. Hard deny:
# Rasmus copy-pastes into Slack himself.
login=$(jq -r '.oauthAccount.emailAddress // ""' ~/.claude.json)
grep -qixF -- "$login" "$HOME/.config/borrowed-logins" 2>/dev/null ||
  exit 0
why="Refused: the active Claude login ($login) is not Rasmus's own, so
its Slack connector would act as that person in Slack. Never send,
schedule, draft, react, or create/edit canvases or conversations from
this login, and don't work around this hook (other tools, scripts,
tokens). Instead give Rasmus the full message text in chat, ready to
paste, with the target channel or thread permalink on its own line;
he posts it himself."
jq -n --arg why "$why" '{hookSpecificOutput: {hookEventName: "PreToolUse",
  permissionDecision: "deny", permissionDecisionReason: $why}}'
