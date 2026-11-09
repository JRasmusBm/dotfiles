#!/bin/sh
#
# tests/tmux-watch.sh — bin/tmux-watch against real tmux servers in a
# temp socket dir: it adopts a running server and starts a missing
# one, notices each death within seconds with its cause (SIGKILL,
# kill-server through the shim, adopted), starts the server again and
# runs tmux-revive (a fake that records the time) at once.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_t="$(mktemp -d)"
export TMUX_TMPDIR="$_t/s" LOCAL_CONFIG="$_t/cfg" TMUX_AGENT_SHARDS=1 \
  TMUX_WATCH_ENV=inherit TMUX_WATCH_TICK=0.2 \
  TMUX_WATCH_REVIVE="$_t/revive" PATH="$_root/shims:$_root/bin:$PATH"
unset TMUX TMUX_PANE
mkdir -p "$TMUX_TMPDIR" "$LOCAL_CONFIG"
_sock="$TMUX_TMPDIR/tmux-$(id -u)"
cat > "$_t/revive" <<'X'
#!/bin/sh
date +%s.%N >> "$LOCAL_CONFIG/revived"
X
chmod +x "$_t/revive"
_w=""
trap 'test -z "$_w" || kill "$_w" 2>/dev/null; for s in default agents-1; do
  tmux -L "$s" kill-server 2>/dev/null; done; rm -rf "$_t"' EXIT

_fail=0
_ok() { echo "ok   $1"; }
_no() { echo "FAIL $1: $2"; _fail=1; }
_pid() { tmux -L "$1" display -p '#{pid}' 2>/dev/null; }
_wait() {
  _i=0
  while ! eval "$1" && test "$_i" -lt 100; do
    sleep 0.1
    _i=$((_i + 1))
  done
  eval "$1"
}

tmux -L default new-session -d -s mine
_p0="$(_pid default)"
"$_root/bin/tmux-watch" & _w=$!
_wait 'test -n "$(_pid agents-1)"' && _ok "missing agents-1 started" \
  || _no "missing agents-1 started" "no server"
test "$(_pid default)" = "$_p0" && _ok "running default adopted, not replaced" \
  || _no "running default adopted" "pid $(_pid default) != $_p0"
"$_root/bin/tmux-watch" status | grep -q "agents-1.*owned" \
  && _ok "status shows agents-1 owned" \
  || _no "status" "$("$_root/bin/tmux-watch" status)"

_died() {
  _wait "grep -q \"$1.*DIED\" \"$LOCAL_CONFIG/tmux-watch.log\" 2>/dev/null"
}

_p1="$(_pid agents-1)"
tmux -L agents-1 new-session -d -s chat
_t0="$(date +%s.%N)"
kill -9 "$_p1"
if _died agents-1; then
  _t1="$(date +%s.%N)"
  _ok "SIGKILL noticed in $(echo "$_t1 - $_t0" | bc | cut -c1-4)s"
else
  _no "SIGKILL noticed" "no DIED row"
fi
grep -q "agents-1.*DIED.*killed by SIGKILL" "$LOCAL_CONFIG/tmux-watch.log" \
  && _ok "cause: killed by SIGKILL" \
  || _no "cause SIGKILL" "$(grep DIED "$LOCAL_CONFIG/tmux-watch.log")"
_wait 'test -n "$(_pid agents-1)" && test "$(_pid agents-1)" != "$_p1"' \
  && _ok "agents-1 started again" || _no "agents-1 restarted" "none"
_wait 'test -s "$LOCAL_CONFIG/revived"' && _ok "tmux-revive run at once" \
  || _no "tmux-revive run" "never"
grep -q "agents-1: killed by SIGKILL" "$LOCAL_CONFIG/tmux-watch.last" \
  && _ok "cause left for revive's ping" || _no "tmux-watch.last" "missing"

: > "$LOCAL_CONFIG/tmux-watch.log"
sh -c 'tmux -L agents-1 kill-server'
_died agents-1
grep -q "agents-1.*DIED.*kill-server: pid=.*parent=.*args=-L agents-1 kill-server" \
  "$LOCAL_CONFIG/tmux-watch.log" && _ok "cause: kill-server names its caller" \
  || _no "cause kill-server" "$(cat "$LOCAL_CONFIG/tmux-watch.log")"

: > "$LOCAL_CONFIG/tmux-watch.log"
kill -9 "$_p0"
_died default
grep -q "default.*DIED.*adopted" "$LOCAL_CONFIG/tmux-watch.log" \
  && _ok "adopted server's death logged" \
  || _no "adopted death" "$(cat "$LOCAL_CONFIG/tmux-watch.log")"
_wait 'test -n "$(_pid default)"' && _ok "default started again" \
  || _no "default restarted" "none"
exit "$_fail"
