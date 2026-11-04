#!/usr/bin/env bash
# PostToolUse hook for Artifact: record each publish with the login that
# owns it. A session sees only its current login's artifacts, so after a
# cswap the other login's links exist only here (`artifacts` reads it).
input=$(cat)
action=$(jq -r '.tool_input.action // "publish"' <<<"$input")
[ "$action" = publish ] || exit 0
[ "$(jq -r '.tool_input.asset // false' <<<"$input")" = true ] && exit 0
url=$(jq -r '.tool_response | tostring' <<<"$input" |
  grep -oE 'https://claude\.ai/(code/)?artifact/[A-Za-z0-9_-]+' | head -1)
[ -n "$url" ] || exit 0
file=$(jq -r '.tool_input.file_path // ""' <<<"$input")
title=$(jq -r '.tool_input.title // ""' <<<"$input")
if [ -z "$title" ] && [ -f "$file" ]; then
  title=$(grep -o -m1 '<title>[^<]*' "$file" | sed 's/<title>//')
fi
[ -n "$title" ] || title=$(basename "${file:-untitled}")
login=$(jq -r '.oauthAccount.emailAddress // "unknown"' ~/.claude.json)
ledger="${LOCAL_CONFIG:-$HOME/.config}/artifacts.tsv"
printf '%s\t%s\t%s\t%s\t%s\t%s\n' "$(date +%s)" "$login" "$url" \
  "$title" "$file" "$PWD" >>"$ledger"
