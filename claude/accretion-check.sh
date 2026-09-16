#!/usr/bin/env bash
# Stop hook: nudge when a session's diff is mostly additions.
git rev-parse --git-dir >/dev/null 2>&1 || exit 0
base=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null) || base=HEAD

summary=$(git diff --numstat "$base" 2>/dev/null | awk '
  $3 ~ /\.(md|mdx|txt|rst)$/ { pa += $1; pd += $2; next }
  $1 ~ /^[0-9]+$/ { ca += $1; cd += $2 }
  END {
    if (pa > 3 * pd + 15) printf "prose +%d/-%d. ", pa, pd
    if (ca > 6 * cd + 80) printf "code +%d/-%d. ", ca, cd
  }')

[ -n "$summary" ] || exit 0
printf '{"systemMessage":"Accretion check — %sRe-read what you changed: name what the new lines supersede, or cut them."}\n' "$summary"
