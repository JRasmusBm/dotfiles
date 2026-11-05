#!/usr/bin/env bash
# PreToolUse hook for Artifact: on a login I can't open claude.ai with
# (someone else's, borrowed for its limits), a published artifact is a
# link I can't follow. So publishes there are refused and the page is
# opened locally instead, and logged to the artifact ledger with its
# file:// path so `artifacts` still lists it. The logins, one per line,
# live in ~/.config/artifact-local-logins (private overlay).
input=$(cat)
action=$(jq -r '.tool_input.action // "publish"' <<<"$input")
[ "$action" = publish ] || exit 0
login=$(jq -r '.oauthAccount.emailAddress // ""' ~/.claude.json)
grep -qixF -- "$login" "$HOME/.config/artifact-local-logins" 2>/dev/null ||
  exit 0

file=$(jq -r '.tool_input.file_path // ""' <<<"$input")
asset=$(jq -r '.tool_input.asset // false' <<<"$input")
if [ "$asset" != true ] && [ -f "$file" ]; then
  file=$(cd "$(dirname "$file")" && pwd -P)/$(basename "$file")
  title=$(jq -r '.tool_input.title // ""' <<<"$input")
  [ -n "$title" ] ||
    title=$(grep -o -m1 '<title>[^<]*' "$file" | sed 's/<title>//')
  [ -n "$title" ] || title=$(basename "$file")
  open "$file"
  ledger="${LOCAL_CONFIG:-$HOME/.config}/artifacts.tsv"
  printf '%s\t%s\t%s\t%s\t%s\t%s\n' "$(date +%s)" "$login" \
    "file://$file" "$title" "$file" "$PWD" >>"$ledger"
  why="Not published: the active login ($login) is not Rasmus's own, so
he can't open claude.ai links from it. The page is open in his local
browser instead and logged in the artifacts ledger. Report it as the
local path file://$file (on its own line) and also send the file with
SendUserFile so he gets it on other devices. Keep editing this file and
'publishing' it the same way: each publish reopens it locally. Don't
retry the publish or work around this hook."
else
  why="Not published: the active login ($login) is not Rasmus's own, so
he can't open claude.ai links from it. Asset uploads and pages created
from an Artifact type need claude.ai: build the page as a local
self-contained .html file instead and publish that file (this hook opens
it locally), or send it with SendUserFile."
fi
jq -n --arg why "$why" '{hookSpecificOutput: {hookEventName: "PreToolUse",
  permissionDecision: "deny", permissionDecisionReason: $why}}'
