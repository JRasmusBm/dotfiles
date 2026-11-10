#!/bin/sh
#
# tests/notif-prio.sh [NOTIF] — `notif next` (M-i) orders by priority
# (bin/prio's file) before class: rank 1 before rank 2 before
# unranked, re-ranked by editing the file; a focused worktree still
# first; a blocked ranked worktree after the other rows of its rank.
# Every place is gone and tmux is a fake that switches nowhere, so one
# `notif next` drops each row in turn and says so: the order of those
# messages is the jump order (a step row's popup shows as `popup`).
# NOTIF defaults to this checkout's bin/notif.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_notif="${1:-$_root/bin/notif}"
_t="$(mktemp -d /tmp/tnp.XXXX)"
trap 'rm -rf "$_t"' EXIT
unset TMUX TMUX_PANE
export LOCAL_CONFIG="$_t/cfg"
mkdir -p "$LOCAL_CONFIG/worktrees" "$_t/bin"
cat > "$_t/bin/tmux" <<X
#!/bin/sh
test "\$1" = display-message && test "\$#" -eq 2 \\
  && echo "\$2" >> "$_t/shown"
test "\$1" = display-message && exit 0
test "\$1" = display-popup && echo "Cleared popup: gone" >> "$_t/shown"
exit 1
X
printf '#!/bin/sh\nexit 1\n' > "$_t/bin/claude-pane"
printf '#!/bin/sh\nexit 1\n' > "$_t/bin/run-slot"
chmod +x "$_t/bin/"*
export PATH="$_t/bin:$_root/bin:$PATH"
_inbox="$LOCAL_CONFIG/notifications"
_w=/nonexistent/repo/.worktrees

_fail=0
ok() { echo "ok   $1"; }
no() { echo "FAIL $1: $2"; _fail=1; }

# Row: epoch ctx title message path pane mode class sid [ref]
_row() { printf '%s\t%s\tt\tm\t%s\t\tsticky\t%s\t\t%s\n' "$@"; }
_rows() {
  {
    _row 100 merge-plain "$_w/plain" merge ""
    _row 101 fyi-two "$_w/abc-2-two" fyi ""
    _row 102 env-one "$_w/abc-1-one" env ""
    _row 103 fyi-one "$_w/abc-1-one-b" fyi ""
    _row 104 prio:two:abc-5 /home step prio:two:abc-5
    _row 105 env-plain "$_w/plain2" env ""
  } > "$_inbox"
}
_order() {
  : > "$_t/shown"
  "$_notif" next "" >/dev/null 2>&1 || true
  sed -n 's/^Cleared \(.*\): gone$/\1/p' "$_t/shown" | tr '\n' ' '
}
_expect() {
  _got="$(_order)"
  test "$_got" = "$2" && ok "$1" || no "$1" "$_got"
}

_rows
: > "$LOCAL_CONFIG/priorities"
_expect "no priorities: class order" \
  "env-one env-plain merge-plain popup fyi-two fyi-one "

cat > "$LOCAL_CONFIG/priorities" <<'X'
One
  - [ ] ABC-1 first
Two
  - [ ] ABC-2 second
  - [ ] ABC-5 another
X
_rows
_expect "ranked before unranked, rank 1 before rank 2" \
  "env-one fyi-one popup fyi-two env-plain merge-plain "

cat > "$LOCAL_CONFIG/priorities" <<'X'
Two
  - [ ] ABC-2 second
  - [ ] ABC-5 another
One
  - [ ] ABC-1 first
X
_rows
_expect "re-ranked by editing the file" \
  "popup fyi-two env-one fyi-one env-plain merge-plain "

printf 'plain\n' > "$_inbox.focus"
_rows
_expect "a focused worktree still first" \
  "merge-plain popup fyi-two env-one fyi-one env-plain "
rm "$_inbox.focus"

printf 'abc-2-two\tfeat/abc-2-two\tabc-1-one\n' \
  > "$LOCAL_CONFIG/worktrees/repo.blocked"
_rows
_expect "blocked ranked row after the rest of its rank" \
  "popup fyi-two env-one fyi-one env-plain merge-plain "
cat > "$LOCAL_CONFIG/priorities" <<'X'
Two
  - [ ] ABC-2 second
One
  - [ ] ABC-1 first
X
{
  _row 100 env-two "$_w/abc-2-two" env ""
  _row 101 fyi-two-b "$_w/abc-2-two-b" fyi ""
  _row 102 env-one "$_w/abc-1-one" env ""
} > "$_inbox"
_expect "blocked: an fyi of its rank goes before its env" \
  "fyi-two-b env-two env-one "

exit "$_fail"
