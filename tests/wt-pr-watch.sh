#!/bin/sh
#
# tests/wt-pr-watch.sh [BIN] — scenarios for bin/wt-pr-watch's CI tells
# (RAS-23: a failed types or lint job tells at once with its error
# lines, while other checks still run; once per head sha; the finished
# run's tell names only failures not told yet). A temp repo with one
# worktree on branch b; gh and wt-tell are fakes first on PATH (gh
# answers `pr list` by running its --jq over $FAKE/prs.json with jq).
# Nothing real is touched. BIN defaults to this checkout's bin/.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_bin="${1:-$_root/bin}"
_t="$(mktemp -d /tmp/wpw.XXXX)"
test -n "${KEEP:-}" || trap 'rm -rf "$_t"' EXIT
export LOCAL_CONFIG="$_t/cfg" FAKE="$_t/fake"
mkdir -p "$LOCAL_CONFIG/worktrees" "$FAKE"
unset WT_CI_FAST
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
  "api repos/{owner}/{repo}/commits/"*) echo 2026-01-01T00:00:00Z ;;
esac
EOF
cat > "$FAKE/wt-tell" <<'EOF'
#!/bin/sh
grep -qxF "$1	$2" "$LOCAL_CONFIG/wt-told" 2>/dev/null && exit 0
printf '%s\n%s\n----\n' "$2" "$4" >> "$FAKE/tells"
printf '%s\t%s\n' "$1" "$2" >> "$LOCAL_CONFIG/wt-told"
EOF
chmod +x "$FAKE/gh" "$FAKE/wt-tell"
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
    headRefOid: $s, latestReviews: [], labels: [],
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

exit "$_fail"
