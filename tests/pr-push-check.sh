#!/bin/sh
#
# tests/pr-push-check.sh [BIN] — scenarios for bin/pr-push-check
# (RAS-125: after a push, a PR that conflicts with its base tells the
# agent to rebase; the repo's `pushed` event runs either way) and for
# `wt w8` refusing a wait on CI or a review while the PR conflicts. A
# temp repo with a worktree on branch b; gh is a fake answering `pr
# view` from $FAKE/states (one "<pr> <mergeable> <base> <sha|HEAD>"
# line per call, the last repeating; empty: no PR). jrb-hook is a fake
# beside a copy of pr-push-check. BIN defaults to this checkout's bin/.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_bin="${1:-$_root/bin}"
_t="$(mktemp -d /tmp/ppc.XXXX)"
test -n "${KEEP:-}" || trap 'rm -rf "$_t"' EXIT
export LOCAL_CONFIG="$_t/cfg" FAKE="$_t/fake" PR_PUSH_WAIT=4 PR_PUSH_STEP=1
mkdir -p "$LOCAL_CONFIG/worktrees" "$FAKE"
_fail=0
ok() { echo "ok   $1"; }
no() { echo "FAIL $1"; _fail=1; }
check() { if eval "$2"; then ok "$1"; else no "$1"; fi; }

git init -q "$_t/r" && git -C "$_t/r" -c core.hooksPath=/dev/null \
  commit -q --allow-empty -m init
git -C "$_t/r" worktree add -q -b b "$_t/r/.worktrees/b"
_wt="$(cd "$_t/r/.worktrees/b" && pwd -P)"
_head="$(git -C "$_wt" rev-parse HEAD)"

cat > "$FAKE/gh" <<'EOF'
#!/bin/sh
test "$1 $2" = "pr view" || exit 1
n="$(cat "$FAKE/n" 2>/dev/null || echo 0)"; n=$((n + 1)); echo "$n" > "$FAKE/n"
l="$(sed -n "${n}p" "$FAKE/states")"
test -n "$l" || l="$(tail -1 "$FAKE/states")"
test -n "$l" || exit 0
set -- $l
sha="$4"; test "$sha" != HEAD || sha="$(git rev-parse HEAD)"
echo "$1 $2 $3 $sha"
EOF
cp "$_bin/pr-push-check" "$FAKE/"
cat > "$FAKE/jrb-hook" <<'EOF'
#!/bin/sh
echo "$*" >> "$FAKE/events"
EOF
chmod +x "$FAKE/gh" "$FAKE/jrb-hook" "$FAKE/pr-push-check"
export PATH="$FAKE:$_bin:$PATH"

# _run <cwd> <command> <state line>... — the hook's output in $_out,
# its events (after the detached run lands) in $_ev.
_run() {
  _c="$1" _cmd="$2"; shift 2
  printf '%s\n' "$@" > "$FAKE/states"
  rm -f "$FAKE/n" "$FAKE/events"
  _out="$(jq -nc --arg c "$_cmd" --arg d "$_c" \
    '{tool_input: {command: $c}, cwd: $d}' | "$FAKE/pr-push-check" hook)"
  sleep 1
  _ev="$(cat "$FAKE/events" 2>/dev/null)"
}

echo '# push to a conflicting PR: told to rebase, pushed event runs'
_run "$_wt" 'git push --force-with-lease' "7 CONFLICTING dev HEAD"
check 'tells conflict' 'printf %s "$_out" | jq -e ".hookSpecificOutput.additionalContext | test(\"PR #7 conflicts with dev\")" >/dev/null'
check 'pushed event' 'test "$_ev" = "$_wt pushed 7 $_head"'

echo '# push to a mergeable PR: silent, pushed event runs'
_run "$_wt" 'git add -A && git commit -qm x; git push' "7 MERGEABLE dev HEAD"
check 'silent' 'test -z "$_out"'
check 'pushed event' 'test "$_ev" = "$_wt pushed 7 $_head"'

echo '# mergeability still computing, or for the old head: waits for it'
_run "$_wt" 'git push' "7 UNKNOWN dev HEAD" "7 MERGEABLE dev old" \
  "7 CONFLICTING dev HEAD"
check 'tells once computed' 'printf %s "$_out" | grep -q conflicts'
check 'polled 3 times' 'test "$(cat "$FAKE/n")" = 3'

echo '# never computed: gives up silently after PR_PUSH_WAIT'
_run "$_wt" 'git push' "7 UNKNOWN dev HEAD"
check 'silent' 'test -z "$_out"'
check 'pushed event still' 'test -n "$_ev"'

echo '# push via cd or -C from elsewhere'
_run "$_t" "cd '$_wt' && git push" "7 CONFLICTING dev HEAD"
check 'cd: tells' 'printf %s "$_out" | grep -q conflicts'
_run "$_t" "git -C $_wt push" "7 CONFLICTING dev HEAD"
check '-C: tells' 'printf %s "$_out" | grep -q conflicts'

echo '# not a push: nothing'
for _nc in 'git status' 'git commit -m "git push later"' 'git pushx' \
  'echo git-push'; do
  _run "$_wt" "$_nc" "7 CONFLICTING dev HEAD"
  check "$_nc" 'test -z "$_out" && test -z "$_ev"'
done

echo '# no open PR: nothing'
_run "$_wt" 'git push' ""
check 'silent, no event' 'test -z "$_out" && test -z "$_ev"'

echo '# conflicts subcommand'
printf '%s\n' "7 CONFLICTING dev HEAD" > "$FAKE/states"; rm -f "$FAKE/n"
check 'conflicting' 'test "$(cd "$_wt" && pr-push-check conflicts)" = "#7 dev"'
printf '%s\n' "7 MERGEABLE dev HEAD" > "$FAKE/states"; rm -f "$FAKE/n"
check 'mergeable' '! (cd "$_wt" && pr-push-check conflicts)'

echo '# wt w8 on CI or a review refused while conflicting'
_w8() {
  printf '%s\n' "$1" > "$FAKE/states"; rm -f "$FAKE/n"
  (cd "$_wt" && wt w8 30m "$2" 2>&1)
}
check 'CI refused' '! _o="$(_w8 "7 CONFLICTING dev HEAD" "CI on PR #7")" && printf %s "$_o" | grep -q "conflicts with dev"'
check 'CodeRabbit refused' '! _w8 "7 CONFLICTING dev HEAD" "CodeRabbit re-review" >/dev/null'
check 'deploy allowed' '_w8 "7 CONFLICTING dev HEAD" "deploy to production" >/dev/null'
check 'CI allowed when mergeable' '_w8 "7 MERGEABLE dev HEAD" "CI on PR #7" >/dev/null'

test "$_fail" = 0 && echo "all ok"
exit "$_fail"
