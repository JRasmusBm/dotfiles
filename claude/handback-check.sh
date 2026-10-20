#!/usr/bin/env bash
# Stop hook: block a turn that hands back a to-do list the agent could
# do itself ("still needs doing", "I'd now…", "I haven't verified X")
# without a real question for me. Each block is logged to
# $LOCAL_CONFIG/handback-blocks.log so the my-impact daily review can
# tell whether it overcorrects (same list re-stopped, scope corrections
# right after a block).
input=$(cat)
[ "$(jq -r '.stop_hook_active // false' <<<"$input")" = true ] && exit 0
transcript=$(jq -r '.transcript_path // empty' <<<"$input")
[ -f "$transcript" ] || exit 0

last_user=$(tail -200 "$transcript" | jq -rs '
  [ .[] | select(.type == "user" and (.message.content | type) == "string")
    | .message.content ] | last // ""')
case "$last_user" in
  *"<<autonomous-loop"*|*"/loop"*|*"I am about to review"*) exit 0 ;;
esac

text=$(tail -60 "$transcript" | jq -rs '
  [ .[] | select(.type == "assistant")
    | .message.content[]? | select(.type == "text") | .text ] | last // ""')
[ -n "$text" ] || exit 0

phrase=$(grep -Eio "still needs doing|what'?s left|remaining work|next steps?|not done yet|I'?d now|I haven'?t (verified|tested|checked|confirmed)|not (checked|verified|tested) yet" \
  <<<"$text" | head -1)
[ -n "$phrase" ] || exit 0

# A real question for me (not "Shall I / Want me to …?") lets it stop.
if grep -Eo '[^.?!]*\?' <<<"$text" \
  | grep -Eqiv '^\s*[-*0-9.)]*\s*(shall I|should I|want me to|do you want me to|say (go|the word)|ok to)'; then
  exit 0
fi

log="${LOCAL_CONFIG:-$HOME/.config}/handback-blocks.log"
printf '%s\t%s\t%s\t%s\n' "$(date +%s)" "$(jq -r '.session_id // ""' <<<"$input")" \
  "$PWD" "$phrase" >> "$log" 2>/dev/null || true

jq -n --arg p "$phrase" '{decision: "block", reason: ("You ended with work left (\"" + $p + "\") and no real question for Rasmus. Do the items you can do yourself now, then report. Where unsure, take the cheap-to-undo option (e.g. a follow-up PR) and ask only about that. Never merge, deploy or post to get there. If something truly needs his decision, end with that one plain-text question and your recommended answer.")}'
