#!/usr/bin/env bash
# PreToolUse hook for the claude.ai Slack connector's write tools. The
# connector acts as the active Claude login's Slack user, so on a
# borrowed login (someone else's, ~/.config/borrowed-logins, private
# overlay) a send would post, react or edit as that person. Hard deny.
# Messages then go through `slack-post` (private overlay, posts as
# Rasmus with his own token) when it exists, else he pastes them.
login=$(jq -r '.oauthAccount.emailAddress // ""' ~/.claude.json)
grep -qixF -- "$login" "$HOME/.config/borrowed-logins" 2>/dev/null ||
  exit 0
why="Refused: the active Claude login ($login) is not Rasmus's own, so
its Slack connector would act as that person in Slack. Never send,
schedule, draft, react, or create/edit canvases or conversations
through this connector on this login."
if command -v slack-post >/dev/null; then
  why="$why Post the message with \`slack-post <permalink|channel-id>
'<text>'\` instead (posts as Rasmus, adds 'Sent using Claude', watches
the thread), under the same rules as a send: only on his word. No
reactions or canvases. If it fails, give him the full text and the
permalink to paste."
else
  why="$why Give Rasmus the full message text in chat, ready to paste,
with the target channel or thread permalink on its own line."
fi
jq -n --arg why "$why" '{hookSpecificOutput: {hookEventName: "PreToolUse",
  permissionDecision: "deny", permissionDecisionReason: $why}}'
