#!/bin/sh
#
# tests/handback-check.sh [SCRIPT] — scenarios for the hand-back Stop
# hook against made-up transcripts, a throwaway repo with a wt
# worktree and a temp board (LOCAL_CONFIG). SCRIPT defaults to this
# checkout's claude/handback-check.sh.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_hook="${1:-$_root/claude/handback-check.sh}"
_t="$(cd "$(mktemp -d)" && pwd -P)"
trap 'rm -rf "$_t"' EXIT
export LOCAL_CONFIG="$_t/cfg"
mkdir -p "$LOCAL_CONFIG/worktrees"
_fail=0

git init -q -b main "$_t/repo"
git -C "$_t/repo" commit -q --no-verify --allow-empty -m init
git -C "$_t/repo" worktree add -q -b feat/jrb/abc-1 "$_t/repo/.worktrees/abc-1"
_wt="$_t/repo/.worktrees/abc-1"

# _tx FILE TEXT [EXTRA_JSONL]: a transcript whose last assistant text
# is TEXT, after a user prompt and EXTRA_JSONL lines.
_tx() {
  {
    jq -cn '{type:"user", message:{role:"user", content:"do the thing"}}'
    test -z "${3:-}" || printf '%s\n' "$3"
    jq -cn --arg t "$2" \
      '{type:"assistant", message:{content:[{type:"text", text:$t}]}}'
  } > "$1"
}

# _run NAME WANT(block|pass) CWD TEXT [EXTRA_JSONL]
_run() {
  _tx "$_t/tx.jsonl" "$4" "${5:-}"
  _out="$(jq -cn --arg p "$_t/tx.jsonl" --arg c "$3" \
    '{transcript_path:$p, cwd:$c, session_id:"s1"}' | (cd "$3" && bash "$_hook"))"
  _got=pass
  printf '%s' "$_out" | grep -q '"decision": *"block"' && _got=block
  if test "$_got" = "$2"; then
    echo "ok   $1"
  else
    echo "FAIL $1: want $2, got $_got ($_out)"
    _fail=1
  fi
}

_promise="PR is up. Once it's merged I'll check it live."
_agent='{"type":"user","message":{"content":[{"type":"tool_result","content":[{"type":"text","text":"Async agent launched successfully.\nagentId: a1b2c3 (internal ID)"}]}]}}'
_agent_done='{"type":"queue-operation","content":"<task-notification>\n<task-id>a1b2c3</task-id>\n<tool-use-id>t</tool-use-id>\n<status>completed</status>"}'
_shell='{"type":"user","message":{"content":[{"type":"tool_result","content":"Command running in background with ID: bzz9"}]}}'

_run 'promise, no wait: blocked' block "$_wt" "$_promise"
_run 'tool tells me, no wait: blocked' block "$_wt" \
  "Pushed. wt-sync will tell me when CI is green."
_run 'plain report: passes' pass "$_wt" "Merged and verified live."
_run 'waits on me: passes' pass "$_wt" \
  "Run the login above. Once you have, I'll check the log."
_run 'promise outside a worktree: passes' pass "$_t/repo" "$_promise"

printf 'abc-1\tfeat/jrb/abc-1\t2099-01-01T10:00\tmerge\t0\t%s\n' \
  "$_t/repo" > "$LOCAL_CONFIG/worktrees/repo.waiting"
_run 'promise with wt w8: passes' pass "$_wt" "$_promise"
rm "$LOCAL_CONFIG/worktrees/repo.waiting"

printf 'abc-1\tfeat/jrb/abc-1\tabc-2\n' > "$LOCAL_CONFIG/worktrees/repo.blocked"
_run 'promise with wt rb: passes' pass "$_wt" "$_promise"
rm "$LOCAL_CONFIG/worktrees/repo.blocked"

printf 'abc-1\tfeat/jrb/abc-1\t2099-01-01\tIN PROGRESS\t0\t%s\n' \
  "$_t/repo" > "$LOCAL_CONFIG/worktrees/repo.snoozed"
_run 'promise with wt sz: passes' pass "$_wt" "$_promise"
rm "$LOCAL_CONFIG/worktrees/repo.snoozed"

_run 'promise, live subagent: passes' pass "$_wt" "$_promise" "$_agent"
_run 'promise, subagent finished: blocked' block "$_wt" "$_promise" \
  "$(printf '%s\n%s' "$_agent" "$_agent_done")"
_run 'promise, live background shell: passes' pass "$_wt" "$_promise" \
  "$_shell"

_run 'hand-back list: blocked' block "$_t/repo" \
  "Done with A. Still needs doing: B and C."

_log="$LOCAL_CONFIG/handback-blocks.log"
if test "$(wc -l < "$_log")" -eq 4 \
  && test "$(grep -c "	promise: " "$_log")" -eq 3; then
  echo "ok   every block logged"
else
  echo "FAIL block log:"; cat "$_log"; _fail=1
fi

exit "$_fail"
