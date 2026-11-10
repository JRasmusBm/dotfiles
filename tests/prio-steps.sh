#!/bin/sh
#
# tests/prio-steps.sh [BIN] — `prio sync` keeps one inbox row per
# priority whose current step no worktree carries: it appears once,
# goes when the step is checked, when a board row carries its ticket
# or when the priority goes; a jump on it opens the priorities popup
# and clears it, and it comes back only after WT_STALL_MIN. Real
# notify/notif on a temp LOCAL_CONFIG; tmux, osascript and afplay are
# logging fakes. BIN defaults to this checkout's bin/.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_bin="${1:-$_root/bin}"
_t="$(mktemp -d /tmp/tps.XXXX)"
trap 'rm -rf "$_t"' EXIT
unset TMUX TMUX_PANE
export LOCAL_CONFIG="$_t/cfg"
mkdir -p "$LOCAL_CONFIG/worktrees" "$_t/bin"
for c in tmux osascript afplay focus-log; do
  printf '#!/bin/sh\necho "%s $*" >> "%s/calls"\n' "$c" "$_t" \
    > "$_t/bin/$c"
done
chmod +x "$_t/bin/"*
export PATH="$_t/bin:$_bin:$PATH"
_f="$LOCAL_CONFIG/priorities"
_inbox="$LOCAL_CONFIG/notifications"
_board="$LOCAL_CONFIG/worktrees/repo"

_fail=0
ok() { echo "ok   $1"; }
no() { echo "FAIL $1"; _fail=1; }
check() { if eval "$2"; then ok "$1"; else no "$1"; fi; }
refs() { cut -f10 "$_inbox" 2>/dev/null | grep . | tr '\n' ' '; }

cat > "$_f" <<'X'
Ship it
  - [ ] write the spec
  - [ ] ABC-2 build it
Other
  - [ ] ABC-3 something
X
printf '# IN PROGRESS\nfeat/jrb/abc-3-something\n' > "$_board"
prio sync
check "a step no worktree carries gets a row" \
  'test "$(refs)" = "prio:ship-it:write-the-spec "'
check "the row is a silent step row named after the step" \
  'awk -F "\t" "\$8 == \"step\" && \$2 == \"prio:ship-it:write-the-spec\" \
     && \$4 == \"Ship it: write the spec\"" "$_inbox" | grep -q . \
   && ! grep -q "osascript\|afplay" "$_t/calls" 2>/dev/null'
prio sync
check "synced again: still one row" \
  'test "$(wc -l < "$_inbox" | tr -d " ")" = 1'

sed -i.bak 's/- \[ \] write/- [x] write/' "$_f"
printf '# IN PROGRESS\nfeat/jrb/abc-3-something\nfeat/jrb/abc-2-build\n' \
  > "$_board"
prio sync
check "step checked, next one on a board row: no row" \
  'test -z "$(refs)"'

printf '# IN PROGRESS\nfeat/jrb/abc-3-something\n' > "$_board"
prio sync
check "its worktree leaves the board: a row for it" \
  'test "$(refs)" = "prio:ship-it:abc-2 "'

printf 'Other\n  - [ ] ABC-3 something\n' > "$_f"
prio sync
check "the priority goes: its row goes" 'test -z "$(refs)"'

printf 'Ship it\n  - [ ] ABC-2 build it\n' > "$_f"
WT_STALL_MIN=0 prio sync
check "it comes back with the priority" \
  'test "$(refs)" = "prio:ship-it:abc-2 "'
: > "$_t/calls"
notif go prio:ship-it:abc-2 prio:ship-it:abc-2 "$HOME"
check "jump opens the priorities popup" \
  'grep -q "^tmux display-popup .*prio edit" "$_t/calls"'
check "jump clears the row" 'test -z "$(refs)"'
prio sync
check "not back before WT_STALL_MIN" 'test -z "$(refs)"'
WT_STALL_MIN=0 prio sync
check "back once it has passed" \
  'test "$(refs)" = "prio:ship-it:abc-2 "'

exit "$_fail"
