#!/bin/sh
#
# tests/tmux-watch-live.sh — bin/tmux-watch moves the live server out of
# /tmp (RAS-41): a server in the old dir is adopted, the next one starts
# in the live dir, and the old dir becomes a plain file, so a tmux that
# falls back there finds no server. Temp dirs stand in for
# ~/.local/state/tmux (TMUX_WATCH_LIVE) and /tmp (TMUX_WATCH_LEGACY);
# every tmux here names its dir, so nothing real is touched.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_t="$(mktemp -d)"
_live="$_t/live" _old="$_t/old"
_uid="$(id -u)"
unset TMUX TMUX_PANE TMUX_TMPDIR
export LOCAL_CONFIG="$_t/cfg" TMUX_WATCH_ENV=inherit TMUX_WATCH_TICK=0.2 \
  TMUX_WATCH_REVIVE="$_t/revive" TMUX_WATCH_LIVE="$_live" \
  TMUX_WATCH_LEGACY="$_old" PATH="$_root/shims:$_root/bin:$PATH"
mkdir -p "$_old" "$LOCAL_CONFIG"
_realtmux=/opt/homebrew/bin/tmux
cat > "$_t/revive" <<'X'
#!/bin/sh
printf '%s\n' "$TMUX_TMPDIR" >> "$LOCAL_CONFIG/revived"
X
chmod +x "$_t/revive"
_w=""
_stop() {
  test -z "$_w" || { kill "$_w" 2>/dev/null; wait "$_w" 2>/dev/null; }
  _w=""
}
# Each socket by path, only if it is there (no TMUX_TMPDIR fallback).
trap '_stop
  for _k in "$_live"/tmux-*/default "$_old"/tmux-*/default \
    "$_old"/tmux-*.old-*/default; do
    test -S "$_k" && "$_realtmux" -S "$_k" kill-server 2>/dev/null
  done
  rm -rf "$_t"' EXIT

_fail=0
_ok() { echo "ok   $1"; }
_no() { echo "FAIL $1: $2"; _fail=1; }
_in() { _d="$1"; shift; env TMUX_TMPDIR="$_d" "$_realtmux" "$@"; }
_pid() { _in "$1" -L default display -p '#{pid}' 2>/dev/null; }
_wait() {
  _i=0
  while ! eval "$1" && test "$_i" -lt 100; do
    sleep 0.1
    _i=$((_i + 1))
  done
  eval "$1"
}

_in "$_old" new-session -d -s agent 'sleep 600'
_p0="$(_pid "$_old")"
"$_root/bin/tmux-watch" & _w=$!
_wait '"$_root/bin/tmux-watch" status | grep -q "adopted.*$_old"' \
  && _ok "server in the old dir adopted" \
  || _no "old server adopted" "$("$_root/bin/tmux-watch" status)"
test ! -e "$_live" && test -d "$_old/tmux-$_uid" \
  && _ok "nothing moved while it runs" || _no "nothing moved" "$(ls "$_t")"

kill -9 "$_p0"
_wait 'test -n "$(_pid "$_live")"' && _ok "next server starts in the live dir" \
  || _no "live dir server" "$(tail -3 "$LOCAL_CONFIG/tmux-watch.log")"
_wait 'test -f "$_old/tmux-$_uid"' \
  && _ok "old socket dir is a plain file now" \
  || _no "old dir blocked" "$(ls -la "$_old")"
_msg="$(_in "$_old" -L default display -p x 2>&1)"
case "$_msg" in
  *"is not a directory"*) _ok "the /tmp fallback finds no server" ;;
  *) _no "fallback blocked" "$_msg" ;;
esac
_lp="$(_pid "$_live")"
_in "$_old" -L default kill-server 2>/dev/null
test "$(_pid "$_live")" = "$_lp" \
  && _ok "raw kill-server through the fallback spares the live server" \
  || _no "live server survives" "pid now '$(_pid "$_live")'"
_wait 'grep -qx "$_live" "$LOCAL_CONFIG/revived" 2>/dev/null' \
  && _ok "tmux-revive told the live dir" \
  || _no "revive dir" "$(cat "$LOCAL_CONFIG/revived" 2>&1)"
rm "$_old/tmux-$_uid"
_wait 'test -f "$_old/tmux-$_uid"' && _ok "a removed block is put back" \
  || _no "block restored" "$(ls -la "$_old")"

# A restart of the watch adopts the live-dir server.
_stop
"$_root/bin/tmux-watch" & _w=$!
_wait '"$_root/bin/tmux-watch" status | grep -q "adopted.*$_live"' \
  && test "$(_pid "$_live")" = "$_lp" \
  && _ok "watch restart adopts the live-dir server" \
  || _no "live adopted" "$("$_root/bin/tmux-watch" status)"
exit "$_fail"
