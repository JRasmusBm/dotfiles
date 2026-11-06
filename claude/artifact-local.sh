#!/usr/bin/env bash
# PreToolUse hook for Artifact: on a login I can't open claude.ai with
# (someone else's, borrowed for its limits), a published artifact is a
# link I can't follow. So publishes there are refused and the page is
# opened locally instead, and logged to the artifact ledger with its
# file:// path so `artifacts` still lists it. The logins, one per line,
# live in ~/.config/borrowed-logins (private overlay).
input=$(cat)
action=$(jq -r '.tool_input.action // "publish"' <<<"$input")
[ "$action" = publish ] || exit 0
login=$(jq -r '.oauthAccount.emailAddress // ""' ~/.claude.json)
grep -qixF -- "$login" "$HOME/.config/borrowed-logins" 2>/dev/null ||
  exit 0

file=$(jq -r '.tool_input.file_path // ""' <<<"$input")
asset=$(jq -r '.tool_input.asset // false' <<<"$input")
if [ "$asset" != true ] && [ -f "$file" ]; then
  file=$(cd "$(dirname "$file")" && pwd -P)/$(basename "$file")
  title=$(jq -r '.tool_input.title // ""' <<<"$input")
  [ -n "$title" ] ||
    title=$(grep -o -m1 '<title>[^<]*' "$file" | sed 's/<title>//')
  [ -n "$title" ] || title=$(basename "$file")
  # Scratchpad paths run ~200 chars and wrap in the terminal, which
  # breaks search in tmux copy-mode: report a short symlink instead.
  base=$(basename "$file")
  link=/tmp/art/$base
  if [ -e "$link" ] && [ "$(readlink "$link")" != "$file" ]; then
    hash=$(printf %s "$file" | shasum | cut -c1-4)
    link=/tmp/art/${base%.*}-$hash.${base##*.}
  fi
  mkdir -p /tmp/art && ln -sfn "$file" "$link"
  open "$link"
  ledger="${LOCAL_CONFIG:-$HOME/.config}/artifacts.tsv"
  printf '%s\t%s\t%s\t%s\t%s\t%s\n' "$(date +%s)" "$login" \
    "file://$link" "$title" "$file" "$PWD" >>"$ledger"
  why="Not published: the active login ($login) is not Rasmus's own, so
he can't open claude.ai links from it. The page is open in his local
browser instead and logged in the artifacts ledger. Report it as the
local path file://$link (on its own line) and, if the SendUserFile tool
is available, send the file with it for other devices. Keep editing
$file and 'publishing' it the same way: each publish reopens it
locally. Don't
retry the publish or work around this hook."
else
  why="Not published: the active login ($login) is not Rasmus's own, so
he can't open claude.ai links from it. Asset uploads and pages created
from an Artifact type need claude.ai: build the page as a local
self-contained .html file instead and publish that file (this hook opens
it locally)."
fi
jq -n --arg why "$why" '{hookSpecificOutput: {hookEventName: "PreToolUse",
  permissionDecision: "deny", permissionDecisionReason: $why}}'
