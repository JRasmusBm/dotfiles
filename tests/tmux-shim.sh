#!/bin/sh
#
# tests/tmux-shim.sh [SHIM] — scenarios for shims/tmux: the guard
# (refusals, kill-server) against a fake tmux that records its args,
# then routing on a real tmux in a temp socket dir. SHIM defaults to
# this checkout's shims/tmux.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_shim="${1:-$_root/shims/tmux}"
_t="$(mktemp -d)"
# The real tmux, as the shim finds it: `command -v -p` can name the shim,
# and a shim run as its own TMUX_REAL execs itself forever.
_realtmux=/opt/homebrew/bin/tmux
_ifs="$IFS"; IFS=:
for _d in $PATH; do
  case "$_d" in */shims) continue ;; esac
  if test -x "$_d/tmux"; then _realtmux="$_d/tmux"; break; fi
done
IFS="$_ifs"
mkdir -p "$_t/s"
trap 'TMUX_TMPDIR="$_t/s" TMUX_REAL="$_realtmux" "$_shim" -L agents-1 \
  kill-server 2>/dev/null; TMUX_TMPDIR="$_t/s" TMUX_REAL="$_realtmux" \
  "$_shim" -L agents-2 kill-server 2>/dev/null; TMUX_TMPDIR="$_t/s" \
  TMUX_REAL="$_realtmux" "$_shim" -L default kill-server 2>/dev/null
  rm -rf "$_t"' EXIT
export LOCAL_CONFIG="$_t/cfg"
mkdir -p "$LOCAL_CONFIG"
cat > "$_t/fake" <<'X'
#!/bin/sh
printf '%s|' "$@" > "$FAKE_OUT"
X
chmod +x "$_t/fake"
export FAKE_OUT="$_t/out"
_uid="$(id -u)"

_fail=0
_ok() { echo "ok   $1"; }
_no() { echo "FAIL $1: $2"; _fail=1; }

# run [env...] -- args: the shim on the fake, no TMUX, real socket dir
run() {
  rm -f "$FAKE_OUT"
  env -u TMUX -u TMUX_TMPDIR -u TMUX_SERVER -u TMUX_KILL_SERVER \
    TMUX_REAL="$_t/fake" TMUX_AGENT_SHARDS=2 "$@" 2>"$_t/err"
}
got() { cat "$FAKE_OUT" 2>/dev/null || echo "<not run>"; }
expect() {
  _g="$(got)"
  if test "$_g" = "$2"; then _ok "$1"; else _no "$1" "got '$_g' want '$2'"
  fi
}
refused() {
  _rc="$3"
  if test "$_rc" -ne 0 && ! test -f "$FAKE_OUT" \
    && grep -q "refused.*$2" "$LOCAL_CONFIG/tmux-guard.log"; then
    _ok "$1"
  else
    _no "$1" "rc=$_rc out=$(got) log=$(tail -1 "$LOCAL_CONFIG/tmux-guard.log" 2>/dev/null)"
  fi
}

run TMUX_TMPDIR="$_t/gone" "$_shim" ls; refused "missing TMUX_TMPDIR refused" \
  "TMUX_TMPDIR empty" $?
run TMUX_TMPDIR= "$_shim" kill-server; refused "empty TMUX_TMPDIR refused" \
  "TMUX_TMPDIR empty" $?
run "$_shim" kill-server; refused "kill-server on default refused" \
  "kill-server /tmp/tmux-$_uid/default" $?
run "$_shim" kill-ser; refused "kill-ser prefix refused" "kill-server" $?
run "$_shim" -L agents-2 kill-server; refused "kill-server on agents-2 refused" \
  "agents-2" $?
run "$_shim" ls \; kill-server; refused "kill-server after ; refused" \
  "kill-server" $?
run TMUX="/private/tmp/tmux-$_uid/agents-1,1,0" "$_shim" kill-server
refused "kill-server via \$TMUX refused" "agents-1" $?
run TMUX_TMPDIR=/tmp "$_shim" kill-server; refused \
  "kill-server with TMUX_TMPDIR=/tmp refused" "kill-server" $?

run TMUX_KILL_SERVER=1 "$_shim" kill-server
expect "TMUX_KILL_SERVER=1 allows it" "kill-server|"
grep -q "allowed: kill-server /tmp/tmux-$_uid/default" \
  "$LOCAL_CONFIG/tmux-guard.log" && _ok "allowed kill-server logged" \
  || _no "allowed kill-server logged" "no row"
run TMUX_TMPDIR="$_t/s" "$_shim" kill-server
expect "kill-server in a test socket dir allowed" "kill-server|"
run "$_shim" -L scratch kill-server
expect "kill-server on another socket name allowed" "-L|scratch|kill-server|"
run "$_shim" send-keys -t kill-server x
expect "kill-server as a value is no command" "send-keys|-t|kill-server|x|"

run "$_shim" send-keys -t %5@agents-1 x Enter
expect "pane key routes and strips" "-L|agents-1|send-keys|-t|%5|x|Enter|"
run "$_shim" display -p -t%7@default '#{pane_pid}'
expect "attached -t routes" "-L|default|display|-p|-t%7|#{pane_pid}|"
run "$_shim" display -p -t 'sess:@3' x
expect "window id is no server" "display|-p|-t|sess:@3|x|"
run TMUX_SERVER=agents-2 "$_shim" ls
expect "TMUX_SERVER routes" "-L|agents-2|ls|"
mkdir -p "$LOCAL_CONFIG/tmux-home"
echo agents-2 > "$LOCAL_CONFIG/tmux-home/foo"
run "$_shim" has-session -t =foo
expect "tmux-home routes a session" "-L|agents-2|has-session|-t|=foo|"
run "$_shim" new-window -d -t '=foo:' -n x
expect "tmux-home routes a window target" \
  "-L|agents-2|new-window|-d|-t|=foo:|-n|x|"
run "$_shim" -L default has-session -t =foo
expect "-L beats tmux-home" "-L|default|has-session|-t|=foo|"
run "$_shim" has-session -t =bar
expect "unknown session stays put" "has-session|-t|=bar|"

_k=$(( $(printf %s ras-9 | cksum | cut -d' ' -f1) % 2 + 1 ))
run "$_shim" new-session -d -s ras-9 -c /r/.worktrees/ras-9
expect "worktree session placed on agents-$_k" \
  "-L|agents-$_k|new-session|-d|-s|ras-9|-c|/r/.worktrees/ras-9|"
test "$(cat "$LOCAL_CONFIG/tmux-home/ras-9")" = "agents-$_k" \
  && _ok "placement recorded" || _no "placement recorded" "no tmux-home"
run "$_shim" new-session -d -s notes -c /r/notes
expect "other session stays on default" "new-session|-d|-s|notes|-c|/r/notes|"
run TMUX_AGENT_SHARDS=0 "$_shim" new-session -d -s ras-8 -c /r/.worktrees/ras-8
expect "0 shards keeps it on default" \
  "new-session|-d|-s|ras-8|-c|/r/.worktrees/ras-8|"

run TMUX="/private/tmp/tmux-$_uid/default,1,0" "$_shim" switch-client \
  -t %3@agents-1
expect "switch to another server detaches into it" \
  "detach-client|-E|exec tmux -L agents-1 attach-session -t '%3'|"
run TMUX="/private/tmp/tmux-$_uid/default,1,0" "$_shim" switch-client \
  -c /dev/ttys001 -t =foo
expect "switch with a client detaches that client" \
  "detach-client|-t|/dev/ttys001|-E|exec tmux -L agents-2 attach-session -t '=foo'|"
run TMUX="/private/tmp/tmux-$_uid/agents-1,1,0" "$_shim" switch-client \
  -t %3@agents-1
expect "switch on the same server stays a switch" \
  "-L|agents-1|switch-client|-t|%3|"

run "$_shim" display -p -t %5@agents-1 '#{pane_id} #S'
expect "pane_id prints its server" \
  "-L|agents-1|display|-p|-t|%5|#{?pane_id,#{pane_id}@#{b:socket_path},} #S|"
run "$_shim" -S /x/sock display -p '#{pane_id}'
expect "pane_id left alone on another socket" \
  "-S|/x/sock|display|-p|#{pane_id}|"
cat > "$_t/fake-env" <<'X'
#!/bin/sh
printf '%s' "$TMUX_PANE" > "$FAKE_OUT"
X
chmod +x "$_t/fake-env"
run TMUX_REAL="$_t/fake-env" TMUX_PANE=%9@agents-2 "$_shim" display -p x
expect "TMUX_PANE reaches tmux bare" "%9"

# Real tmux in a temp socket dir: placement, then lookups by name.
_rt() {
  env -u TMUX -u TMUX_SERVER TMUX_TMPDIR="$_t/s" TMUX_REAL="$_realtmux" \
    TMUX_AGENT_SHARDS=2 "$_shim" "$@"
}
mkdir -p "$_t/r/.worktrees/abc-1"
_rt new-session -d -s abc-1 -c "$_t/r/.worktrees/abc-1" 2>"$_t/err" \
  || _no "real new-session" "$(cat "$_t/err")"
_srv="$(cat "$LOCAL_CONFIG/tmux-home/abc-1" 2>/dev/null)"
if test -n "$_srv" && "$_realtmux" -S "$_t/s/tmux-$_uid/$_srv" \
  has-session -t =abc-1 2>/dev/null; then
  _ok "real session made on $_srv"
else
  _no "real session made on an agents server" "srv='$_srv'"
fi
_rt has-session -t =abc-1 && _ok "real lookup by name" \
  || _no "real lookup by name" "has-session failed"
_p="$(_rt display -p -t =abc-1: '#{pane_id}')"
case "$_p" in %*@agents-*) ;; *) _p="" ;; esac
test -n "$_p" && _rt display -p -t "$_p" '#S' | grep -qx abc-1 \
  && _ok "real pane key round-trips ($_p)" \
  || _no "real pane key round-trips" "$_p"
"$_realtmux" -S "$_t/s/tmux-$_uid/default" has-session 2>/dev/null \
  && _no "default untouched" "a default server started" \
  || _ok "default untouched"

_rt new-session -d -s mine -c "$_t" 2>/dev/null
_all="$(_rt list-panes -a -F '#{pane_id} #S' | sort -k2 | tr '\n' ' ')"
case "$_all" in
  "%"*"@$_srv abc-1 %"*"@default mine ") _ok "list-panes -a spans servers" ;;
  *) _no "list-panes -a spans servers" "$_all" ;;
esac
test "$(_rt ls -F '#S' | sort | tr '\n' ' ')" = "abc-1 mine " \
  && _ok "ls spans servers" || _no "ls spans servers" "$(_rt ls -F '#S')"
test "$(_rt list-panes -t =mine: -F '#S')" = mine \
  && _ok "list-panes -t stays on its server" || _no "list-panes -t" "?"
test "$(_rt list-panes -s -t =abc-1 -F '#S' | sort -u)" = abc-1 \
  && _ok "list-panes -s -t stays on its server" \
  || _no "list-panes -s -t" "$(_rt list-panes -s -t =abc-1 -F '#S' 2>&1)"
# A missing session prints no pane: an `@default` alone would read as one.
_p="$(_rt display -p -t =gone:cli '#{pane_id}')"
test -z "$_p" && _ok "no pane, no pane key" || _no "no pane, no pane key" "$_p"

exit "$_fail"
