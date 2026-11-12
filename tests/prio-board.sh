#!/bin/sh
#
# tests/prio-board.sh [PRIO] — `prio sync` keeps each board's `# P0`
# section: rows on a priority move in, in rank order, from any section
# but the parking and post-merge ones; a row whose priority goes moves
# back to the section it came from (the `.p0` side file); with none
# left the heading goes. LOCAL_CONFIG is a temp dir; notify, notif and
# tmux are fakes; Linear fails, so sync keeps the tickets cache this
# test writes. PRIO defaults to this checkout's bin/prio.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_prio="${1:-$_root/bin/prio}"
_t="$(mktemp -d /tmp/tpb.XXXX)"
trap 'rm -rf "$_t"' EXIT
unset TMUX TMUX_PANE
export LOCAL_CONFIG="$_t/cfg"
mkdir -p "$LOCAL_CONFIG/worktrees" "$_t/bin"
for c in tmux notify notif; do printf '#!/bin/sh\n' > "$_t/bin/$c"; done
chmod +x "$_t/bin/"*
export PATH="$_t/bin:$PATH" PRIO_LINEAR_CMD=false
_f="$LOCAL_CONFIG/priorities"
_b="$LOCAL_CONFIG/worktrees/repo"

_fail=0
ok() { echo "ok   $1"; }
no() { echo "FAIL $1"; _fail=1; }
check() { if eval "$2"; then ok "$1"; else no "$1"; fi; }
board() { tr '\n' '|' < "$_b"; }
# prios "<outcome> <TICKET>..." ...: the file, in rank order, and what
# Linear last said is in each.
prios() {
  : > "$_f"; : > "$_f.tickets"
  for _p in "$@"; do
    set -- $_p
    printf '%s\n  in label:%s\n' "$1" "$1" >> "$_f"
    _o="$1"; shift
    for _k in "$@"; do printf '%s\t%s\topen\tt\n' "$_o" "$_k" >> "$_f.tickets"; done
  done
}

cat > "$_b" <<'X'
# IN PROGRESS
feat/jrb/abc-2-two
other

# TEAM REVIEW
feat/jrb/abc-1-one

# PROD REVIEW
fix/jrb/abc-3-shipped
X
prios "One ABC-1" "Two ABC-2 ABC-3"
"$_prio" sync
check "ranked rows move to # P0 at the top, in rank order" \
  'test "$(board)" = "# P0|feat/jrb/abc-1-one|feat/jrb/abc-2-two|# IN PROGRESS|other||# TEAM REVIEW||# PROD REVIEW|fix/jrb/abc-3-shipped|"'
check "side file keeps where each came from" \
  'test "$(tr "\t\n" ":|" < "$_b.p0")" = "feat/jrb/abc-2-two:IN PROGRESS|feat/jrb/abc-1-one:TEAM REVIEW|"'
_m="$(stat -f %m "$_b")"
"$_prio" sync
check "nothing changed: board untouched" \
  'test "$(stat -f %m "$_b")" = "$_m" && test "$(board)" = "# P0|feat/jrb/abc-1-one|feat/jrb/abc-2-two|# IN PROGRESS|other||# TEAM REVIEW||# PROD REVIEW|fix/jrb/abc-3-shipped|"'

prios "Two ABC-2" "One ABC-1"
"$_prio" sync
check "re-ranked: # P0 follows the file" \
  'test "$(sed -n 2,3p "$_b" | tr "\n" "|")" = "feat/jrb/abc-2-two|feat/jrb/abc-1-one|"'

prios "Two ABC-2"
"$_prio" sync
check "priority gone: back to its own section, in its free slot" \
  'test "$(board)" = "# P0|feat/jrb/abc-2-two|# IN PROGRESS|other||# TEAM REVIEW|feat/jrb/abc-1-one|# PROD REVIEW|fix/jrb/abc-3-shipped|"'

prios
"$_prio" sync
check "no priority left: heading gone, rows home" \
  'test "$(board)" = "# IN PROGRESS|other|feat/jrb/abc-2-two|# TEAM REVIEW|feat/jrb/abc-1-one|# PROD REVIEW|fix/jrb/abc-3-shipped|" \
   && test ! -e "$_b.p0"'
check "PROD REVIEW row left alone throughout" \
  'grep -A1 "^# PROD REVIEW" "$_b" | grep -q abc-3-shipped'

exit "$_fail"
