#!/bin/sh
#
# tests/wt-tell-held.sh [BIN] — scenarios for wt-tell holding
# WT_TELL_CAN_WAIT tells to parked worktrees, wt-held, and the
# quiet-wakes UserPromptSubmit hook (RAS-59). Nothing real is touched:
# LOCAL_CONFIG, HOME and the repo are a temp dir; tmux and run-slot are
# logging fakes first on PATH. BIN defaults to this checkout's bin/.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_bin="${1:-$_root/bin}"
_t="$(mktemp -d /tmp/wth.XXXX)"
test -n "${KEEP:-}" || trap 'rm -rf "$_t"' EXIT
export LOCAL_CONFIG="$_t/cfg" FAKE="$_t/fake" HOME="$_t/home"
mkdir -p "$LOCAL_CONFIG/worktrees" "$LOCAL_CONFIG/run-slots" \
  "$FAKE/bin" "$HOME/.claude"
ln -s "$_bin" "$HOME/.bin"
ln -s "$_root/claude/quiet-wakes.sh" "$HOME/.claude/quiet-wakes.sh"

# tmux: list-sessions prints $FAKE/sa (name, attached, last attached,
# created; missing = no sessions); every other query finds nothing.
cat > "$FAKE/bin/tmux" <<'EOF'
#!/bin/sh
echo "tmux $*" >> "$FAKE/calls"
case "$*" in
  list-sessions*) test -f "$FAKE/sa" && cat "$FAKE/sa" ;;
  *) exit 1 ;;
esac
EOF
for c in run-slot notif notify claude-pane claude-pane-idle; do
  printf '#!/bin/sh\necho "%s $*" >> "$FAKE/calls"\nexit 1\n' "$c" \
    > "$FAKE/bin/$c"
done
chmod +x "$FAKE/bin/"*
export PATH="$FAKE/bin:$_bin:$PATH"

_repo="$_t/repo"
git init -q -b main "$_repo"
git -C "$_repo" commit -q --allow-empty -m init
git -C "$_repo" worktree add -q -b feat/x "$_repo/.worktrees/x"
_wt="$_repo/.worktrees/x"
_held="$LOCAL_CONFIG/worktrees/repo.held"
_board="$LOCAL_CONFIG/worktrees/repo"

_fail=0
ok() { echo "ok   $1"; }
no() { echo "FAIL $1"; _fail=1; }
check() { if eval "$2"; then ok "$1"; else no "$1"; fi; }
_n=0
# tell [CAN_WAIT] [root]: a fresh key each time.
tell() {
  _n=$((_n + 1)) _k="k$_n"
  : > "$FAKE/calls"
  WT_TELL_CAN_WAIT="${1:-}" wt-tell "${2:-$_wt}" "$_k" ping "hello $_n"
}
ago() { echo $(( $(date +%s) - $1 * 3600 )); }
# sa ATTACHED LAST CREATED: the worktree's session, beside another.
sa() { printf 'other\t1\t1\t1\nx\t%s\t%s\t%s\n' "$@" > "$FAKE/sa"; }
held() { grep -q "	$_k	" "$_held" 2>/dev/null; }
reset() {
  rm -f "$_held" "$_held.log" "$LOCAL_CONFIG/worktrees/repo.waiting" \
    "$LOCAL_CONFIG/run-slots/keep"
  printf '# IN PROGRESS\nfeat/x\n' > "$_board"
  sa 0 "$(ago 7)" "$(ago 9)"
}

echo '# parked: last attached 7h ago, nothing open'
reset
tell 1; _rc=$?
check 'can-wait tell is held' 'held'
check 'exits 0' 'test $_rc = 0'
check 'and counts as told' "grep -qxF '$_wt	$_k' '$LOCAL_CONFIG/wt-told'"
check 'no run-slot (no revive, no tell)' '! grep -q ^run-slot $FAKE/calls'
check 'tabs/newlines in prompt flattened' \
  "test \"\$(awk -F '\t' 'END { print NF }' '$_held')\" = 4"
wt-tell "$_wt" "$_k" ping again; _c="$(grep -c . "$_held")"
check 'same key again: not held twice' 'test "$_c" = 1'
tell; check 'without CAN_WAIT: not held' '! held'
check '... it goes on to revive/tell' 'grep -q ^run-slot $FAKE/calls'

echo '# not parked'
reset; sa 1 "$(ago 0)" "$(ago 9)"
tell 1; check 'attached now: told' '! held'
reset; sa 0 "$(ago 1)" "$(ago 9)"
tell 1; check 'attached 1h ago: told' '! held'
export WT_PARK_HOURS=1
tell 1; check 'WT_PARK_HOURS=1, 1h ago: held' 'held'
unset WT_PARK_HOURS
reset; printf 'x\tfeat/x\t2099-01-01T00:00\tci\t1\t\n' \
  > "$LOCAL_CONFIG/worktrees/repo.waiting"
tell 1; check 'open wt w8: told' '! held'
reset; echo x > "$LOCAL_CONFIG/run-slots/keep"
tell 1; check 'in run-slots/keep: told' '! held'
for s in P0 'TEAM REVIEW' 'READY TO DEPLOY'; do
  reset; printf '# IN PROGRESS\nother\n# %s\nfeat/x\n' "$s" > "$_board"
  tell 1; check "board row in $s: told" '! held'
done
reset; printf 'PROD REVIEW:\n  x\n' > "$_board"
tell 1; check 'PROD REVIEW (by slug, colon heading): held' 'held'
reset; tell 1 "$_repo"; check 'main checkout: never held' '! held'
reset; rm -f "$FAKE/sa"
tell 1; check 'no tmux session at all: held' 'held'
reset; sa 0 '' "$(ago 1)"
tell 1; check 'never attached, started 1h ago: told' '! held'
reset; sa 0 '' "$(ago 7)"
tell 1; check 'never attached, started 7h ago: held' 'held'
reset; printf 'xx\t1\t%s\t1\n' "$(ago 0)" > "$FAKE/sa"
tell 1; check 'only another session attached: held' 'held'

echo '# wt-held'
reset; tell 1; tell 1
check 'count = 2' 'test "$(wt-held count "$_wt")" = 2'
check 'list shows age, key, prompt' \
  'wt-held list "$_wt" | grep -q "^[0-9]*m ago	k[0-9]*	hello"'
check 'count from main checkout = 0' 'test "$(wt-held count "$_repo")" = 0'
wt-held done "$_wt"
check 'done: count 0' 'test "$(wt-held count "$_wt")" = 0'
check 'done: rows in .log with done time' \
  "test \"\$(awk -F '\t' 'NF == 5' '$_held.log' | grep -c .)\" = 2"

echo '# quiet-wakes hook'
_hook="$HOME/.claude/quiet-wakes.sh"
_end='<task-notification>
<task-type>artifact-watch-lifecycle</task-type>
<summary>Stopped watching Artifact: "Some page" (artifact not found)</summary>
<event>Watch on https://claude.ai/artifact/abc ended.</event>
</task-notification>'
hook() { jq -n --arg p "$1" --arg c "$2" '{prompt: $p, cwd: $c}' | "$_hook"; }
_o="$(hook "$_end" "$_wt")"
check 'watch ended: blocked' \
  'test "$(printf "%s" "$_o" | jq -r .decision)" = block'
reset; tell 1
_o="$(hook 'hi' "$_wt")"
check 'held rows: nudge to catch-up' \
  'printf "%s" "$_o" | grep -q "held 1 tell(s).*catch-up"'
wt-held done "$_wt"
check 'nothing held: silent' 'test -z "$(hook hi "$_wt")"'
check 'outside a repo: silent' 'test -z "$(hook hi /)"'
check 'other task notifications pass' \
  'test -z "$(hook "<task-notification><task-type>local_bash</task-type>" /)"'

exit "$_fail"
