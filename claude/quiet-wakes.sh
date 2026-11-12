#!/bin/sh
# UserPromptSubmit hook. Each wake of an idle session re-reads its whole
# chat (~120k tokens), so:
# - An artifact watch ending (every cswap login change ends each watch
#   as "artifact not found") never reaches the model: blocked here,
#   before any model call. There is nothing to do about it.
# - In a worktree with tells wt-tell held while it was parked, the
#   prompt gets one line saying so, so its agent runs /catch-up.
_in="$(cat)"
_p="$(printf '%s' "$_in" | jq -r '.prompt // ""')"
case "$_p" in
  *'<task-type>artifact-watch-lifecycle</task-type>'*'Stopped watching'*)
    printf '%s\n' '{"decision":"block","reason":"artifact watch ended (dropped by quiet-wakes)","suppressOutput":true}'
    exit 0 ;;
esac
_n="$(~/.bin/wt-held count "$(printf '%s' "$_in" | jq -r '.cwd // "."')" \
  2>/dev/null)"
test "${_n:-0}" -gt 0 2>/dev/null || exit 0
printf 'While this worktree was parked, wt-tell held %s tell(s) for it ' "$_n"
printf '(wt-held lists them). Load the catch-up skill before acting on '
printf 'them, unless the message above asks for something else first.\n'
