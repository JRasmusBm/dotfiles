#!/usr/bin/env bash
# Stop hook: block a turn that
#  - hands back a to-do list the agent could do itself ("still needs
#    doing", "I'd now…", "I haven't verified X") without a real
#    question for me, or
#  - promises later work ("once it's live I'll…", "CI will tell me")
#    from a worktree whose board row has no `wt w8`, `wt sz` or
#    `wt rb`, with no background agent or shell still running: nothing
#    would bring it back, so I end up asking "status?".
# Each block is logged to $LOCAL_CONFIG/handback-blocks.log so the
# my-impact daily review can tell whether it overcorrects (same list
# re-stopped, scope corrections right after a block).
input=$(cat)
[ "$(jq -r '.stop_hook_active // false' <<<"$input")" = true ] && exit 0
transcript=$(jq -r '.transcript_path // empty' <<<"$input")
[ -f "$transcript" ] || exit 0
cwd=$(jq -r '.cwd // empty' <<<"$input")
cwd=${cwd:-$PWD}

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

block() {
  log="${LOCAL_CONFIG:-$HOME/.config}/handback-blocks.log"
  printf '%s\t%s\t%s\t%s\n' "$(date +%s)" \
    "$(jq -r '.session_id // ""' <<<"$input")" "$cwd" "$1" \
    >> "$log" 2>/dev/null || true
  jq -n --arg r "$2" '{decision: "block", reason: $r}'
  exit 0
}

# --- hand-back ----------------------------------------------------

handback() {
  phrase=$(grep -Eio "still needs doing|what'?s left|remaining work|next steps?|not done yet|I'?d now|I haven'?t (verified|tested|checked|confirmed)|not (checked|verified|tested) yet|say go|your go\b|waiting for you to say|when you say|say the word|I recommend yes" \
    <<<"$text" | head -1)
  [ -n "$phrase" ] || return 0

  # Only I can unblock it (my login, MFA, go-ahead on something risky):
  # a real stop, not a hand-back.
  grep -Eqi "needs? your (go-ahead|login|MFA|approval)|only you can" \
    <<<"$text" && return 0

  # A real question for me (not "Shall I / Want me to …?") lets it stop.
  if grep -Eo '[^.?!]*\?' <<<"$text" \
    | grep -Eqiv '^\s*[-*0-9.)]*\s*(shall I|should I|want me to|do you want me to|say (go|the word)|ok to)'; then
    return 0
  fi

  block "$phrase" "You ended with work left (\"$phrase\") and no real question for Rasmus. Do the items you can do yourself now, then report. Where unsure, take the cheap-to-undo option (e.g. a follow-up PR) and ask only about that. Never merge, deploy or post to get there. If something truly needs his decision, end with that one plain-text question and your recommended answer."
}

# --- promise with no wait -----------------------------------------

# A background agent or shell launched in this session that has not
# sent its final task-notification yet: it re-invokes the agent.
live_background() {
  launched=$(grep -Eoh 'agentId: [a-z0-9]+|running in background with ID: [a-z0-9]+' \
    "$transcript" | awk '{ print $NF }' | sort -u)
  [ -n "$launched" ] || return 1
  ended=$(grep -Eo '<task-id>[a-z0-9]+</task-id>([^<]|<[^s])*<status>(completed|failed|killed|stopped)</status>' \
    "$transcript" | grep -Eo '<task-id>[a-z0-9]+' | cut -d'>' -f2 | sort -u)
  [ -n "$(comm -23 <(echo "$launched") <(echo "$ended"))" ]
}

promise() {
  # A clause that waits on me ("when you say send, I'll…") is a
  # question, not a promise: my reply brings the agent back.
  phrase=$(grep -Eio "(once|when|after|as soon as)\b[^.?!]{0,80}\bI'?ll\b|\bI'?ll\b[^.?!]{0,80}\b(once|when|as soon as)\b[^.?!]*|\bwill (tell|notify|ping|wake|let) me\b|\bI'?ll (check|report) back\b" \
    <<<"$text" | grep -Eiv '\byou' | head -1)
  [ -n "$phrase" ] || return 0

  # Only a wt worktree has a board row to carry the wait.
  top=$(git -C "$cwd" rev-parse --show-toplevel 2>/dev/null) || return 0
  case "$top" in */.worktrees/*) ;; *) return 0 ;; esac
  common=$(git -C "$cwd" rev-parse --path-format=absolute --git-common-dir)
  slug=$(basename "$top")
  board="${LOCAL_CONFIG:-$HOME/.config}/worktrees/$(basename "$(dirname "$common")")"
  for f in "$board.waiting" "$board.snoozed" "$board.blocked"; do
    [ -f "$f" ] && awk -F '\t' -v s="$slug" '$1 == s { f = 1 } END { exit !f }' "$f" \
      && return 0
  done
  live_background && return 0

  block "promise: $phrase" "You promised later work (\"$phrase\") but nothing brings you back: no wt w8, wt sz or wt rb on this worktree and no background agent or shell running. Do it now if you can. Otherwise set what wakes you (wt w8 <estimate> \"<what>\" for an event, wt sz <when> for a time, wt rb <ticket> for another PR), then end the turn."
}

handback
promise
