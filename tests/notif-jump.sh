#!/bin/sh
#
# tests/notif-jump.sh [NOTIF] — a failed M-i jump (`notif next`)
# never drops a row silently: a place that is there but won't take
# the switch keeps its rows and says so; a gone place is dropped and
# says so. A throwaway tmux server with no client, so every switch
# fails. NOTIF defaults to this checkout's bin/notif.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_notif="${1:-$_root/bin/notif}"
# Short: a tmux socket path must fit in 104 bytes.
_t="$(mktemp -d /tmp/tnj.XXXX)"
unset TMUX TMUX_PANE
export TMUX_TMPDIR="$_t/s" LOCAL_CONFIG="$_t/cfg"
trap 'tmux kill-server 2>/dev/null; rm -rf "$_t"' EXIT
mkdir -p "$TMUX_TMPDIR" "$LOCAL_CONFIG" "$_t/bin"

# Fakes: no chat runs anywhere; tmux logs what it shows the user.
_realtmux="$(PATH="$(printf '%s' "$PATH" | tr : '\n' \
  | grep -v '/shims$' | paste -sd: -)" command -v tmux)"
printf '#!/bin/sh\nexit 1\n' > "$_t/bin/claude-pane"
printf '#!/bin/sh\nexit 1\n' > "$_t/bin/run-slot"
cat > "$_t/bin/tmux" <<X
#!/bin/sh
test "\$1" = display-message && test "\$#" -eq 2 \\
  && echo "\$2" >> "$_t/shown"
exec "$_realtmux" "\$@"
X
chmod +x "$_t/bin/"*
export PATH="$_t/bin:$_root/bin:$PATH"

_fail=0
_ok() { echo "ok   $1"; }
_no() { echo "FAIL $1: $2"; _fail=1; }

tmux -f /dev/null new-session -d -s live -c "$_t" 'sleep 60'
_p="$(tmux display -p -t =live: '#{pane_id}')"
_inbox="$LOCAL_CONFIG/notifications"
_row() { printf '%s\t%s\tt\tm\t%s\t%s\tsticky\t\t%s\n' "$@"; }
{
  _row 100 live "$_t" "$_p" ""
  _row 101 gone-x /nonexistent %999 ""
  _row 102 live "$_t" "$_p@default" sid-1
} > "$_inbox"

_rc=0; "$_notif" next "" || _rc=$?
test "$_rc" -ne 0 && _ok "next fails when nothing switched (rc $_rc)" \
  || _no "next rc" "$_rc"
test "$(cut -f6 "$_inbox" | sort | tr '\n' ' ')" = "$_p $_p@default " \
  && _ok "live place keeps its rows" || _no "live rows" "$(cat "$_inbox")"
grep -q '%999' "$_inbox" && _no "gone row" "still pending" \
  || _ok "gone place dropped"
grep -q '%999' "$LOCAL_CONFIG/notifications.recent" \
  && _ok "gone row moved to recent" || _no "gone in recent" "missing"
grep -qx 'Cleared gone-x: gone' "$_t/shown" \
  && _ok "drop says so" || _no "drop message" "$(cat "$_t/shown")"
grep -qx 'Could not switch to live (kept in the inbox)' "$_t/shown" \
  && _ok "stuck jump says so" || _no "stuck message" "$(cat "$_t/shown")"

_rc=0; "$_notif" go %999 gone-y /nonexistent || _rc=$?
test "$_rc" -eq 1 && _ok "go to a gone place: rc 1" || _no "go gone" "rc=$_rc"
_rc=0; "$_notif" go "$_p@default" live "$_t" || _rc=$?
test "$_rc" -eq 2 && grep -q "$_p" "$_inbox" \
  && _ok "go to a stuck place keeps it (rc 2)" || _no "go stuck" "rc=$_rc"

exit "$_fail"
