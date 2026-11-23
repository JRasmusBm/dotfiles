#!/bin/sh
#
# tests/wt-doc.sh [BIN] — RAS-108: `wt doc` opens a worktree's
# .jrb/doc.md (this one, or one named by branch, dir or `wt :`
# picker line), `wt doc path` prints it, and the `wt :` preview
# shows the doc's top. A fake nvim records what it opens. BIN
# defaults to this checkout's bin/.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_bin="${1:-$_root/bin}"
_t="$(cd "$(mktemp -d /tmp/wdoc.XXXX)" && pwd -P)"
test -n "${KEEP:-}" || trap 'rm -rf "$_t"' EXIT
unset TMUX TMUX_PANE CLAUDECODE
export LOCAL_CONFIG="$_t/cfg" FAKE="$_t/fake"
mkdir -p "$LOCAL_CONFIG/worktrees" "$FAKE/bin"
printf '#!/bin/sh\nprintf "%%s\\n" "$*" > "$FAKE/opened"\n' \
  > "$FAKE/bin/nvim"
chmod +x "$FAKE/bin/nvim"
export PATH="$FAKE/bin:$_bin:$PATH"
export GIT_CONFIG_COUNT=1 GIT_CONFIG_KEY_0=core.hooksPath \
  GIT_CONFIG_VALUE_0=/dev/null

_r="$_t/repo"
git init -q "$_r"
git -C "$_r" commit -q --allow-empty -m init
git -C "$_r" worktree add -q "$_r/.worktrees/abc-1" -b feat/x/abc-1
git -C "$_r" worktree add -q "$_r/.worktrees/abc-2" -b feat/x/abc-2
_w1="$_r/.worktrees/abc-1"
mkdir -p "$_w1/.jrb"
printf '# ABC-1: thing\nNow: testing the picker\n' > "$_w1/.jrb/doc.md"

_fail=0
check() { if eval "$2"; then echo "ok   $1"; else
  echo "FAIL $1"; _fail=1; fi; }

check "path: this worktree" \
  '[ "$(cd "$_w1" && wt doc path)" = "$_w1/.jrb/doc.md" ]'
check "path: another by branch" \
  '[ "$(cd "$_r" && wt doc path feat/x/abc-2)" = "$_r/.worktrees/abc-2/.jrb/doc.md" ]'

rm -f "$FAKE/opened"
(cd "$_w1/.jrb" && wt doc) </dev/null
check "open: this worktree, read-only" \
  '[ "$(cat "$FAKE/opened" 2>/dev/null)" = "-R $_w1/.jrb/doc.md" ]'

rm -f "$FAKE/opened"
(cd "$_r" && wt doc 'IN PROGRESS: feat/x/abc-1') </dev/null
check "open: from a picker line" \
  '[ "$(cat "$FAKE/opened" 2>/dev/null)" = "-R $_w1/.jrb/doc.md" ]'

rm -f "$FAKE/opened"
_err="$( (cd "$_r" && wt doc abc-2) </dev/null 2>&1)"
_rc=$?
check "no doc: says so, fails, opens nothing" \
  '[ $_rc -ne 0 ] && [ ! -f "$FAKE/opened" ] &&
   echo "$_err" | grep -q "no doc yet"'

_err="$( (cd "$_r" && wt doc nope) </dev/null 2>&1)"
check "unknown worktree: says so" \
  'echo "$_err" | grep -q "no worktree nope"'

_pv="$(wt-preview "$_r" 'IN PROGRESS: feat/x/abc-1')"
check "preview: shows the doc top" \
  'echo "$_pv" | grep -q "^Now: testing the picker$"'

exit $_fail
