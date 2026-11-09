#!/bin/sh
#
# tests/wt-sync-w8.sh [BIN] — scenarios for the overdue `wt w8` tells in
# bin/wt-sync and the told-key check in bin/wt-tell (RAS-27: every
# overdue w8 not yet told is told, old ones too; only a deadline since
# the last run triggers the wt-cold --overdue ping). Nothing real is
# touched: LOCAL_CONFIG and the repos are a temp dir, every command
# wt-sync calls but these two is a logging fake first on PATH. BIN
# defaults to this checkout's bin/ (point it at another to compare).

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_bin="${1:-$_root/bin}"
_t="$(mktemp -d /tmp/wsw.XXXX)"
test -n "${KEEP:-}" || trap 'rm -rf "$_t"' EXIT
export LOCAL_CONFIG="$_t/cfg" FAKE="$_t/fake"
mkdir -p "$LOCAL_CONFIG/worktrees" "$FAKE/bin" "$_t/r/ice" "$_t/r/dot"
_w8="$LOCAL_CONFIG/worktrees"
_ub="$LOCAL_CONFIG/wt-unblocked"
export WT_SYNC_REPOS="$_t/r/ice $_t/r/dot"

# Every neighbour logs its argv. wt-tell fails (not delivered), so what
# wt-sync queued stays in wt-unblocked to read. route prints nothing:
# not metered.
for c in tmux-revive run-slot btabs wt wt-cold jrb-hook wt-pr-watch \
  wt-tell route ipconfig notif; do
  printf '#!/bin/sh\necho "%s $*" >> "$FAKE/calls"\n' "$c" \
    > "$FAKE/bin/$c"
  chmod +x "$FAKE/bin/$c"
done
echo 'exit 1' >> "$FAKE/bin/wt-tell"
_path="$FAKE/bin:$_bin:$PATH"

_fail=0
ok() { echo "ok   $1"; }
no() { echo "FAIL $1"; _fail=1; }
check() { if eval "$2"; then ok "$1"; else no "$1"; fi; }
sync() { : > "$FAKE/calls"; PATH="$_path" wt-sync >/dev/null 2>&1; }
queued() { grep -c "	w8:$1:" "$_ub" 2>/dev/null || true; }
cold() { grep -q '^wt-cold --overdue' "$FAKE/calls"; }

_ago() { date -v-"$1" +%FT%H:%M; }
_row() { # slug deadline start [main]
  printf '%s\tb/%s\t%s\twhat %s\t%s\t%s\n' "$1" "$1" "$2" "$1" "$3" \
    "${4:-}"
}

echo '# old + fresh + future + unlisted'
_row old "2026-11-07T08:50" 100 > "$_w8/ice.waiting"
_row fresh "$(_ago 3M)" 200 >> "$_w8/ice.waiting"
_row later "$(date -v+2H +%FT%H:%M)" 300 >> "$_w8/ice.waiting"
_row lost "2026-11-07T08:50" 400 > "$_w8/gone.waiting"
_row ext "$(_ago 3H)" 500 "$_t/r/ext" >> "$_w8/gone.waiting"
_ago 10M > "$LOCAL_CONFIG/wt-w8-stamp"
sync
check 'old (before the stamp) is told' 'test "$(queued old)" = 1'
check 'fresh is told' 'test "$(queued fresh)" = 1'
check 'future deadline is not told' 'test "$(queued later)" = 0'
check 'no main checkout, repo unlisted: skipped' \
  'test "$(queued lost)" = 0'
check 'row carrying its main checkout, unlisted repo: told' \
  'test "$(queued ext)" = 1'
check 'old row resolves through the list' \
  'grep -q "^$_t/r/ice/.worktrees/old	" "$_ub"'
check 'retried each run (wt-tell called)' \
  'grep -q "^wt-tell .*w8:old:100" "$FAKE/calls"'
check 'fresh one pings wt-cold --overdue' cold
check 'stamp moved to now' \
  'test "$(cat "$LOCAL_CONFIG/wt-w8-stamp")" = "$(date +%FT%H:%M)"'

echo '# next run: same rows still overdue, none fresh'
sync
check 'queue not duplicated' \
  'test "$(queued old)" = 1 && test "$(queued fresh)" = 1'
check 'no fresh deadline: no wt-cold --overdue' '! cold'

echo '# only old rows: told, no ping'
: > "$_ub"; rm -f "$_w8/gone.waiting"
_row old "2026-11-07T08:50" 100 > "$_w8/ice.waiting"
_ago 1M > "$LOCAL_CONFIG/wt-w8-stamp"
sync
check 'old told' 'test "$(queued old)" = 1'
check 'no wt-cold --overdue' '! cold'

echo '# no stamp yet (first run)'
: > "$_ub"; rm -f "$LOCAL_CONFIG/wt-w8-stamp"
sync
check 'old told on the first run too' 'test "$(queued old)" = 1'
check 'no wt-cold --overdue' '! cold'
check 'stamp written' 'test -s "$LOCAL_CONFIG/wt-w8-stamp"'

echo '# wt-tell: a told w8 key whose row lingers'
_r="$_t/r/ice/.worktrees/old"
printf '%s\tw8:old:100\n' "$_r" > "$LOCAL_CONFIG/wt-told"
{ _row old "2026-11-07T08:50" 100; _row other "2026-11-07T08:50" 9; } \
  > "$_w8/ice.waiting"
: > "$FAKE/calls"
PATH="$FAKE/bin:$_bin:$PATH" "$_bin/wt-tell" "$_r" w8:old:100 m p
check 'exits 0 (nothing to retry)' 'test $? = 0'
check 'that w8 row ends' '! grep -q "^old	" "$_w8/ice.waiting"'
check 'other rows kept' 'grep -q "^other	" "$_w8/ice.waiting"'
check 'its overdue inbox row drops' \
  'grep -q "^notif seen-ref ice/old" "$FAKE/calls"'
check 'told once: no second tell' \
  '! grep -qv "^notif seen-ref" "$FAKE/calls"'
printf '%s\tw8:old:100\n' "$_r" > "$LOCAL_CONFIG/wt-told"
_row old "2026-11-07T08:50" 777 > "$_w8/ice.waiting"
PATH="$FAKE/bin:$_bin:$PATH" "$_bin/wt-tell" "$_r" w8:old:100 m p
check 'a newer w8 of that worktree is kept' \
  'grep -q "^old	.*	777	" "$_w8/ice.waiting"'
printf '%s\tci:1:abc\n' "$_r" > "$LOCAL_CONFIG/wt-told"
PATH="$FAKE/bin:$_bin:$PATH" "$_bin/wt-tell" "$_r" ci:1:abc m p
check 'a told non-w8 key leaves the w8 alone' \
  'grep -q "^old	" "$_w8/ice.waiting"'

printf '%s\tping:w8:old:100\n' "$_r" > "$LOCAL_CONFIG/wt-told"
_row old "2026-11-07T08:50" 100 > "$_w8/ice.waiting"
PATH="$FAKE/bin:$_bin:$PATH" "$_bin/wt-tell" "$_r" w8:old:100 m p
check 'a pinged w8 (no session then) ends too, exit 0' \
  'test $? = 0 && ! grep -q "^old	" "$_w8/ice.waiting"'

echo '# wt-tell: the revived chat has the tell pending'
: > "$LOCAL_CONFIG/wt-told"; : > "$FAKE/calls"
mkdir -p "$LOCAL_CONFIG/run-slots" "$_r"
printf '1\ttell:old:w8:old:100\t[]\n' > "$LOCAL_CONFIG/run-slots/pending"
_row old "2026-11-07T08:50" 100 > "$_w8/ice.waiting"
PATH="$FAKE/bin:$_bin:$PATH" "$_bin/wt-tell" "$_r" w8:old:100 m p
check 'exits 0 and leaves it to the pending run' \
  'test $? = 0 && ! test -s "$FAKE/calls"'
check 'the w8 stays until that run tells it' \
  'grep -q "^old	" "$_w8/ice.waiting"'
: > "$FAKE/calls"
RUN_SLOT_PENDING=1 PATH="$FAKE/bin:$_bin:$PATH" "$_bin/wt-tell" "$_r" \
  w8:old:100 m p
check 'the pending run itself goes on to tell' \
  'grep -q "^run-slot\|^wt open\|^notif" "$FAKE/calls" || test -s "$LOCAL_CONFIG/wt-told"'

exit "$_fail"
