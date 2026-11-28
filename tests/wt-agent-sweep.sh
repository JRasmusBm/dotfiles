#!/bin/sh
#
# tests/wt-agent-sweep.sh [BIN] — RAS-124: `wt clean --agents` sweeps
# a subagent worktree untouched past WT_AGENT_TTL (head pinned in
# refs/wt first, dir moved aside), keeps a fresh one, one a live
# process has as cwd and one a live pid has locked. Everything runs
# in a temp dir. BIN defaults to this checkout's bin/.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_bin="${1:-$_root/bin}"
_t="$(cd "$(mktemp -d /tmp/wags.XXXX)" && pwd -P)"
_pids=""
trap 'kill $_pids 2>/dev/null; test -n "${KEEP:-}" || rm -rf "$_t"' EXIT
unset TMUX TMUX_PANE
export LOCAL_CONFIG="$_t/cfg" FAKE="$_t/fake"
mkdir -p "$LOCAL_CONFIG/worktrees" "$FAKE/bin"
for c in tmux notif notify tsp jrb-hook gh lin; do
  printf '#!/bin/sh\nexit 1\n' > "$FAKE/bin/$c"
  chmod +x "$FAKE/bin/$c"
done
export PATH="$FAKE/bin:$_bin:$PATH"
export GIT_CONFIG_COUNT=1 GIT_CONFIG_KEY_0=core.hooksPath \
  GIT_CONFIG_VALUE_0=/dev/null

_fail=0
check() { if eval "$2"; then echo "ok   $1"; else echo "FAIL $1"
  _fail=1; fi; }

_r="$_t/app"
git init -q "$_r"
git -C "$_r" commit -q --allow-empty -m init
_old="$(($(date +%s) - 7 * 3600))"
for a in stale dirty fresh cwd locked; do
  _p="$_r/.claude/worktrees/agent-$a"
  GIT_COMMITTER_DATE="@$_old +0000" git -C "$_r" worktree add -q \
    -b "worktree-agent-$a" "$_p"
  test "$a" = fresh && git -C "$_p" commit -q --allow-empty -m new
  test "$a" = fresh || GIT_COMMITTER_DATE="@$_old +0000" \
    git -C "$_p" commit -q --allow-empty -m old
done
echo x > "$_r/.claude/worktrees/agent-dirty/x"
touch -t "$(date -r "$_old" +%Y%m%d%H%M)" \
  "$_r/.claude/worktrees/agent-dirty/x"
( cd "$_r/.claude/worktrees/agent-cwd" && exec sleep 300 ) &
_pids="$_pids $!"
sleep 300 & _pids="$_pids $!"
git -C "$_r" worktree lock --reason \
  "claude agent agent-locked (pid $! start now)" \
  "$_r/.claude/worktrees/agent-locked"
_stale_sha="$(git -C "$_r/.claude/worktrees/agent-stale" rev-parse HEAD)"

( cd "$_r" && wt clean --agents ) 2>"$_t/err"
_w="$_r/.claude/worktrees"
check "stale swept" "! test -d $_w/agent-stale"
check "stale head pinned" \
  "test \"\$(git -C $_r rev-parse refs/wt/agent-stale)\" = $_stale_sha"
check "stale branch deleted" \
  "! git -C $_r rev-parse -q --verify refs/heads/worktree-agent-stale"
check "stale unregistered from git" \
  "! git -C $_r worktree list | grep -q agent-stale"
check "dirty swept with a snapshot" \
  "git -C $_r show refs/wt/agent-dirty:x >/dev/null 2>&1"
check "fresh kept" "test -d $_w/agent-fresh"
check "live cwd kept" "test -d $_w/agent-cwd"
check "live lock kept" "test -d $_w/agent-locked"
check "reports count" "grep -q 'removed 2 agent' $_t/err"

kill $_pids 2>/dev/null; wait 2>/dev/null; _pids=""
( cd "$_r" && wt clean --agents ) 2>/dev/null
check "dead lock swept" "! test -d $_w/agent-locked"
check "cwd freed then swept" "! test -d $_w/agent-cwd"
sleep 1
check "trash emptied" "! test -d $_r/.git/wt-trash"

exit "$_fail"
