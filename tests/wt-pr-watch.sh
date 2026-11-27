#!/bin/sh
#
# tests/wt-pr-watch.sh [BIN] — scenarios for bin/wt-pr-watch's CI tells
# (RAS-23: a failed types or lint job tells at once with its error
# lines, while other checks still run; once per head sha; the finished
# run's tell names only failures not told yet) and CodeRabbit tells
# (RAS-93: a review of the head that opens threads tells their count
# and titles, once per review; RAS-126: from the 3rd round still
# opening a Critical or Major, it asks "split it, or ship with
# deferrals?" and pings me once per PR; RAS-134: a ping that never
# reached my inbox is not counted, so the next such round pings). A temp repo with one worktree on
# branch b; gh and wt-tell are fakes first on PATH (gh answers `pr
# list` by running its --jq over $FAKE/prs.json, and `api --paginate
# .../pulls/<path>` over $FAKE/api/<path, / as _>.json, with jq; notify is
# a fake too, logging to $FAKE/pings).
# Nothing real is touched. BIN defaults to this checkout's bin/.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_bin="${1:-$_root/bin}"
_t="$(mktemp -d /tmp/wpw.XXXX)"
test -n "${KEEP:-}" || trap 'rm -rf "$_t"' EXIT
export LOCAL_CONFIG="$_t/cfg" FAKE="$_t/fake"
mkdir -p "$LOCAL_CONFIG/worktrees" "$FAKE"
unset WT_CI_FAST CR TELL_DOWN
_fail=0
ok() { echo "ok   $1"; }
no() { echo "FAIL $1"; _fail=1; }
check() { if eval "$2"; then ok "$1"; else no "$1"; fi; }

git init -q "$_t/r" && git -C "$_t/r" -c core.hooksPath=/dev/null commit -q --allow-empty -m init
git -C "$_t/r" worktree add -q -b b "$_t/r/.worktrees/b"
_wt="$_t/r/.worktrees/b"

cat > "$FAKE/gh" <<'EOF'
#!/bin/sh
case "$1 $2" in
  "api user") echo me ;;
  "pr list")
    while test $# -gt 0; do
      test "$1" = --jq && { jq -r "$2" "$FAKE/prs.json"; exit; }; shift
    done ;;
  "run view")
    echo "run view $*" >> "$FAKE/runs"
    test "$4" = 11 || exit 0
    t="$(printf '\t')"
    echo "lint${t}UNKNOWN STEP${t}2026-11-18T21:28:38.1Z "
    echo "lint${t}UNKNOWN STEP${t}2026-11-18T21:28:38.1Z /home/runner/work/ice/ice/frontend/src/A.tsx"
    echo "lint${t}UNKNOWN STEP${t}2026-11-18T21:28:38.2Z ##[error]  25:9  error  Promises must be awaited"
    echo "lint${t}UNKNOWN STEP${t}2026-11-18T21:28:38.3Z ##[error]  30:1  error  Unsafe any"
    echo "types${t}Run x${t}2026-11-18T17:20:04.8Z ##[error]src/w.test.ts(5,68): error TS2322: Type mismatch"
    echo "types${t}Run x${t}2026-11-18T17:20:05.1Z ##[error]Process completed with exit code 2." ;;
  "pr view") echo - ;;
  "api --paginate")
    f="$FAKE/api/$(echo "$3" | sed 's|.*/pulls/||; s|/|_|g').json"
    test -f "$f" || f=/dev/null
    jq -r "$5" "$f" ;;
  "api repos/{owner}/{repo}/commits/"*) echo 2026-01-01T00:00:00Z ;;
esac
EOF
cat > "$FAKE/wt-tell" <<'EOF'
#!/bin/sh
test -z "${TELL_DOWN:-}" || exit 1
grep -qxF "$1	$2" "$LOCAL_CONFIG/wt-told" 2>/dev/null && exit 0
printf '%s\n%s\n----\n' "$2" "$4" >> "$FAKE/tells"
printf '%s\t%s\n' "$1" "$2" >> "$LOCAL_CONFIG/wt-told"
EOF
# notify: logs the ping and appends its inbox row, unless NOTIFY_DROP
# (a ping that never reached the inbox).
cat > "$FAKE/notify" <<'EOF'
#!/bin/sh
test -z "${NOTIFY_DROP:-}" || exit 0
printf '%s %s\n' "$NOTIFY_CLASS" "$2" >> "$FAKE/pings"
printf '%s\tc\t%s\t%s\t%s\t\t\t%s\t\t%s\n' "$(date +%s)" "$1" "$2" \
  "$PWD" "$NOTIFY_CLASS" "${NOTIFY_REF:-}" >> "$LOCAL_CONFIG/notifications"
EOF
chmod +x "$FAKE/gh" "$FAKE/wt-tell" "$FAKE/notify"
export PATH="$FAKE:$_bin:$PATH"

# _pr <sha> <check>... — PR #7 on b; a check is name:workflow:state
# (fail, pass, run). Job ids: 11 for fast failures that log, else 99.
_pr() {
  _s="$1"; shift
  for _c; do
    _n="${_c%%:*}" _r="${_c#*:}"; _w="${_r%%:*}" _st="${_r#*:}"
    case "$_st" in
      fail) _cs='"conclusion":"FAILURE","status":"COMPLETED"' ;;
      pass) _cs='"conclusion":"SUCCESS","status":"COMPLETED"' ;;
      run) _cs='"conclusion":"","status":"IN_PROGRESS"' ;;
    esac
    _id=99; case "$_n" in types|lint) _id=11 ;; esac
    printf '{"name":"%s","workflowName":"%s",%s,"detailsUrl":"https://x/actions/runs/1/job/%s"}\n' \
      "$_n" "$_w" "$_cs" "$_id"
  done | jq -s --arg s "$_s" '[{number: 7, headRefName: "b",
    headRefOid: $s, labels: [],
    latestReviews: (if env.CR then [{author: {login: "coderabbitai"},
      submittedAt: env.CR}] else [] end),
    statusCheckRollup: .}]' > "$FAKE/prs.json"
}
_run() { : > "$FAKE/tells"; ( cd "$_t/r" && wt-pr-watch ) >/dev/null 2>&1; }
told() { grep -c "^$1\$" "$FAKE/tells"; }

echo '# types fails, the rest still runs'
_pr s1 types:check-frontend:fail lint:check-frontend:pass \
  test:check-services:run
_run
check 'early tell, at once' 'test "$(told ci-early:7:s1)" = 1'
check 'no finished-run tell yet' 'test "$(told ci:7:s1)" = 0'
check 'it names the job and workflow' \
  'grep -q "PR #7: types (check-frontend) failed" "$FAKE/tells"'
check 'it carries the error lines' \
  'grep -q "TS2322: Type mismatch" "$FAKE/tells"'
check 'and the file eslint named, repo-relative' \
  'grep -qx "frontend/src/A.tsx" "$FAKE/tells"'
check 'not the exit-code line' '! grep -q "Process completed" "$FAKE/tells"'

echo '# next minute, lint fails too, still running'
_pr s1 types:check-frontend:fail lint:check-frontend:fail \
  test:check-services:run
_run
check 'no second early tell on that sha' 'test ! -s "$FAKE/tells"'

echo '# the run finishes: lint and test failed as well'
_pr s1 types:check-frontend:fail lint:check-frontend:fail \
  test:check-services:fail
_run
check 'finished-run tell' 'test "$(told ci:7:s1)" = 1'
check 'it names only what was not told' \
  'grep -q "PR #7 (lint (check-frontend),test (check-services), besides the types (check-frontend) I told you about)" "$FAKE/tells"'

echo '# fix pushed; only types fails, after the rest passed'
_pr s2 types:check-services:run test:check-services:run
_run
check 'nothing while running green' 'test ! -s "$FAKE/tells"'
_pr s2 types:check-services:fail test:check-services:run
_run
check 'early tell on the new sha' 'test "$(told ci-early:7:s2)" = 1'
_pr s2 types:check-services:fail test:check-services:pass
_run
check 'no finished-run tell: nothing new' 'test ! -s "$FAKE/tells"'

echo '# a slow job fails, the rest still runs'
_pr s3 types:check-services:pass test:check-services:fail e2e:e2e:run
_run
check 'waits for the whole run' 'test ! -s "$FAKE/tells"'
_pr s3 types:check-services:pass test:check-services:fail e2e:e2e:pass
_run
check 'then tells' 'grep -q "PR #7 (test (check-services))" "$FAKE/tells"'

echo '# types fails as the last check: one tell, the finished one'
_pr s4 test:check-services:pass types:check-services:fail
_run
check 'no early tell' 'test "$(told ci-early:7:s4)" = 0'
check 'finished-run tell names it' 'test "$(told ci:7:s4)" = 1'

# _review <id> <sha> — CodeRabbit review <id> of <sha>, added to #7's
# reviews. _thread <review id> <title> [reply|<severity>] — a comment
# it posted (default Minor).
mkdir -p "$FAKE/api"
echo '[]' > "$FAKE/api/7_reviews.json"
echo '[]' > "$FAKE/api/7_comments.json"
_review() {
  jq --argjson i "$1" --arg s "$2" \
    '. + [{id: $i, commit_id: $s, user: {login: "coderabbitai[bot]"}}]' \
    "$FAKE/api/7_reviews.json" | sponge "$FAKE/api/7_reviews.json"
}
_thread() {
  _f="$FAKE/api/7_comments.json"
  _sev="${3:-Minor}"; test "$_sev" != reply || _sev=Minor
  jq --argjson i "$1" --arg t "$2" --arg r "${3:-}" --arg v "$_sev" \
    '. + [{path: "src/a.ts", pull_request_review_id: $i,
    user: {login: "coderabbitai[bot]"},
    in_reply_to_id: (if $r == "reply" then 1 else null end),
    body: "<!-- x -->\n\n**<picture></picture> \($v)** · **Bug**\n\n**\($t)**\n\nmore"}]' \
    "$_f" | sponge "$_f"
}

echo '# CodeRabbit reviews the head and opens two threads'
export CR=2026-11-19T10:00:00Z
_pr s5 test:check-services:run
_review 501 s5; _thread 501 'Await the promise.'
_thread 501 'Guard the null.' Major; _thread 501 'Reply text' reply
_run
check 'one tell for the review' 'test "$(told cr:7:501)" = 1'
check 'it counts the new threads' \
  'grep -q "opened 2 threads:" "$FAKE/tells"'
check 'it gives their titles' \
  'grep -qx -- "- Await the promise. (src/a.ts)" "$FAKE/tells" \
    && grep -qx -- "- Guard the null. (src/a.ts)" "$FAKE/tells"'
check 'not the badge line' '! grep -q "picture" "$FAKE/tells"'
check 'round 1 with a Major: no question' '! grep -q "split it" "$FAKE/tells"'
_run
check 'once per review' 'test ! -s "$FAKE/tells"'

echo '# it re-reviews the push: replies only, no new threads'
export CR=2026-11-19T10:20:00Z
_pr s6 test:check-services:run
_review 502 s6; _thread 502 'Thanks' reply
_run
check 'no tell' 'test ! -s "$FAKE/tells"'

echo '# a review of an older sha after a push'
export CR=2026-11-19T10:30:00Z
_pr s7 test:check-services:run
_review 503 s6; _thread 503 'Old finding.'
_run
check 'no tell' 'test ! -s "$FAKE/tells"'

echo '# a review of the head while no Claude takes the tell'
export CR=2026-11-19T10:40:00Z TELL_DOWN=1
_pr s7 test:check-services:run
_review 504 s7; _thread 504 'One finding.'
_run
check 'nothing told yet' 'test ! -s "$FAKE/tells"'
unset TELL_DOWN
_run
check 'retried next run, singular' \
  'test "$(told cr:7:504)" = 1 && grep -q "opened 1 thread:" "$FAKE/tells"'

pinged() { test -f "$FAKE/pings" && grep -c "$1" "$FAKE/pings"; }

echo '# round 4 (501, 503 of an older sha, 504 before it) opens a Major,'
echo '# and its ping to me never reaches the inbox (an older row with'
echo '# the same ref sits there already)'
printf '1\tc\tt\tm\t/p\t\t\tblocked\t\tcr-rounds:7\n' \
  >> "$LOCAL_CONFIG/notifications"
export CR=2026-11-19T11:00:00Z NOTIFY_DROP=1
_pr s8 test:check-services:run
_review 505 s8; _thread 505 'Second-round major.' Major
_run
unset NOTIFY_DROP
check 'tells the threads' 'test "$(told cr:7:505)" = 1'
check 'it counts the rounds' 'grep -q "round 4 on this PR" "$FAKE/tells"'
check 'it gives Majors per round' \
  'grep -q "per round: 1,0,0,1)" "$FAKE/tells"'
check 'it asks the question' \
  'grep -q "split it, or ship with" "$FAKE/tells"'
check 'the dropped ping is not recorded as told' \
  '! grep -q "cr-rounds:7" "$LOCAL_CONFIG/wt-told"'

echo '# round 5, only Minors: no question'
export CR=2026-11-19T11:20:00Z
_pr s9 test:check-services:run
_review 506 s9; _thread 506 'A nit.'
_run
check 'tells the threads' 'test "$(told cr:7:506)" = 1'
check 'no question' '! grep -q "split it" "$FAKE/tells"'

echo '# round 6, a Critical: asks again, and pings me this time'
export CR=2026-11-19T11:40:00Z
_pr s10 test:check-services:run
_review 507 s10; _thread 507 'Data loss.' Critical
_thread 507 'Also major.' Major
_run
check 'asks with the Criticals counted' \
  'grep -q "round 6 on this PR" "$FAKE/tells" \
    && grep -q "per round: 1,0,0,1,0,2)" "$FAKE/tells"'
check 'pings me, blocked, now that the last one was dropped' \
  'test "$(pinged "^blocked #7: 6 CodeRabbit rounds, Majors 1,0,0,1,0,2")" = 1'
check 'and records it told' 'grep -q "cr-rounds:7" "$LOCAL_CONFIG/wt-told"'

echo '# round 7, a Major again: no second ping'
export CR=2026-11-19T12:00:00Z
_pr s11 test:check-services:run
_review 508 s11; _thread 508 'Still major.' Major
_run
check 'asks the agent again' 'grep -q "round 7 on this PR" "$FAKE/tells"'
check 'one ping per PR' 'test "$(pinged "#7:")" = 1'

exit "$_fail"
