#!/usr/bin/env bash
# Stop hook: block a turn that
#  - hands back a to-do list the agent could do itself ("still needs
#    doing", "I'd now…", "I haven't verified X") without a real
#    question for me, or
#  - promises later work ("once it's live I'll…", "CI will tell me")
#    from a worktree whose board row has no `wt w8`, `wt sz` or
#    `wt rb`, with no background agent or shell still running: nothing
#    would bring it back, so I end up asking "status?", or
#  - waits on a PR ("waiting for #123") with no `wt rb` on it (or a
#    `wt w8` naming it): only rb wakes on merge, close and carry. One
#    such turn slept 17.7h on a PR closed for another (RAS-84).
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

# The reply that just ended, from the hook input: the transcript can
# lag it, so its tail held an older reply and blocked on that (RAS-106).
text=$(jq -r '.last_assistant_message // empty' <<<"$input")
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

  block "$phrase" "You ended with work left (\"$phrase\") and no real question for Rasmus. Give this moment to a subagent (flow skill, waiting node) and act on its answer."
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

# Only a wt worktree has a board row to carry the wait: sets $slug
# and $board, fails elsewhere.
board_of() {
  top=$(git -C "$cwd" rev-parse --show-toplevel 2>/dev/null) || return 1
  case "$top" in */.worktrees/*) ;; *) return 1 ;; esac
  common=$(git -C "$cwd" rev-parse --path-format=absolute --git-common-dir)
  slug=$(basename "$top")
  board="${LOCAL_CONFIG:-$HOME/.config}/worktrees/$(basename "$(dirname "$common")")"
}

promise() {
  # A clause that waits on me ("when you say send, I'll…") is a
  # question, not a promise: my reply brings the agent back.
  phrase=$(grep -Eio "(once|when|after|as soon as)\b[^.?!]{0,80}\bI'?ll\b|\bI'?ll\b[^.?!]{0,80}\b(once|when|as soon as)\b[^.?!]*|\bwill (tell|notify|ping|wake|let) me\b|\bI'?ll (check|report) back\b" \
    <<<"$text" | grep -Eiv '\byou' | head -1)
  [ -n "$phrase" ] || return 0

  board_of || return 0
  for f in "$board.waiting" "$board.snoozed" "$board.blocked"; do
    [ -f "$f" ] && awk -F '\t' -v s="$slug" '$1 == s { f = 1 } END { exit !f }' "$f" \
      && return 0
  done
  live_background && return 0

  block "promise: $phrase" "You promised later work (\"$phrase\") but nothing brings you back: no wt w8, wt sz or wt rb on this worktree and no background agent or shell running. Do it now if you can. Otherwise set what wakes you (wt w8 <estimate> \"<what>\" for an event, wt sz <when> for a time, wt rb <ticket> for another PR), then end the turn."
}

# --- wait on a PR with no rb ---------------------------------------

pr_wait() {
  phrase=$(grep -Eio "\b(wait(ing|s)?|blocked|parked)\b (for|on|by|until)\b([^.?!]|\.[^[:space:]]){0,80}(#[0-9]+|/pull/[0-9]+)" \
    <<<"$text" | head -1)
  [ -n "$phrase" ] || return 0
  board_of || return 0
  # A background agent or shell re-invokes this turn anyway.
  live_background && return 0
  prs=$(grep -Eo '#[0-9]+|/pull/[0-9]+' <<<"$phrase" | grep -Eo '[0-9]+')
  for n in $prs; do
    # rb on that PR, or on a worktree (its PR is polled too).
    [ -f "$board.blocked" ] && awk -F '\t' -v s="$slug" -v n="$n" '
      $1 == s && ($3 == "#" n || $3 ~ "/pull/" n "$" \
        || ($3 != "" && $3 !~ /^(#|https:)/)) { f = 1 }
      END { exit !f }' "$board.blocked" && return 0
    # A w8 that names it (its own CI, say): a deadline someone checks.
    [ -f "$board.waiting" ] && awk -F '\t' -v s="$slug" -v n="$n" '
      $1 == s && $4 ~ "#" n "([^0-9]|$)" { f = 1 } END { exit !f }' \
      "$board.waiting" && return 0
  done
  n=$(head -1 <<<"$prs")
  block "pr-wait: $phrase" "You wait on a PR (\"$phrase\") but no wt rb is set on it. A w8 only fires at its deadline and wt merged only on merge: run wt rb #$n, which wakes you when it merges, closes, or another PR carries it (a wt w8 naming #$n for your own PR's CI). Then end the turn."
}

handback
pr_wait
promise
