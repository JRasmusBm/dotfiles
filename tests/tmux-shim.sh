#!/bin/sh
#
# tests/tmux-shim.sh [SHIM] — scenarios for shims/tmux: the guard
# (refusals, kill-server) against a fake tmux that records its args,
# then a real tmux in a temp socket dir. SHIM defaults to
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
mkdir -p "$_t/s" "$_t/live"
# No $TMUX anywhere below: tmux targets $TMUX's server over TMUX_TMPDIR,
# so a kill-server here would kill the server the test runs in.
unset TMUX TMUX_PANE
# Cleanup names each socket by path: real tmux given a TMUX_TMPDIR that
# is gone falls back to /tmp, and kill-server there kills every agent.
trap 'for _k in "$_t"/s/tmux-*/default "$_t"/live/tmux-*/default; do
    test -S "$_k" && "$_realtmux" -S "$_k" kill-server 2>/dev/null
  done
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
  env -u TMUX -u TMUX_TMPDIR -u TMUX_KILL_SERVER \
    TMUX_REAL="$_t/fake" "$@" 2>"$_t/err"
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
run "$_shim" ls \; kill-server; refused "kill-server after ; refused" \
  "kill-server" $?
run TMUX="/private/tmp/tmux-$_uid/default,1,0" "$_shim" kill-server
refused "kill-server via \$TMUX refused" "default" $?
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

run "$_shim" send-keys -t %5@default x Enter
expect "a split-era pane key loses @default" "send-keys|-t|%5|x|Enter|"
run "$_shim" display -p -t%7@default '#{pane_pid}'
expect "attached -t loses @default" "display|-p|-t%7|#{pane_pid}|"
run "$_shim" send-keys -t %5@agents-1 x
expect "an agents-N key stays (no such pane)" "send-keys|-t|%5@agents-1|x|"
run "$_shim" display -p -t 'sess:@3' '#{pane_id}'
expect "window id and pane_id left alone" "display|-p|-t|sess:@3|#{pane_id}|"
cat > "$_t/fake-env" <<'X'
#!/bin/sh
printf '%s' "$TMUX_PANE" > "$FAKE_OUT"
X
chmod +x "$_t/fake-env"
run TMUX_REAL="$_t/fake-env" TMUX_PANE=%9@default "$_shim" display -p x
expect "TMUX_PANE reaches tmux bare" "%9"

# A TMUX_TMPDIR of its own beats the live pane's $TMUX (RAS-41).
cat > "$_t/fake-tmux" <<'X2'
#!/bin/sh
printf '%s|%s' "${TMUX-<unset>}" "${TMUX_PANE-<unset>}" > "$FAKE_OUT"
X2
chmod +x "$_t/fake-tmux"
_live="/private/tmp/tmux-$_uid/default,1,0"
run TMUX_REAL="$_t/fake-tmux" TMUX="$_live" TMUX_PANE=%3 \
  TMUX_TMPDIR="$_t/s" "$_shim" display -p x
expect "own TMUX_TMPDIR drops live TMUX and TMUX_PANE" "<unset>|<unset>"
_sd="$(cd "$_t/s" && pwd -P)"
run TMUX_REAL="$_t/fake-tmux" TMUX="$_sd/tmux-$_uid/default,1,0" \
  TMUX_PANE=%3 TMUX_TMPDIR="$_t/s" "$_shim" display -p x
expect "a pane of the TMUX_TMPDIR server keeps TMUX" \
  "$_sd/tmux-$_uid/default,1,0|%3"
for _d in /tmp /tmp/ /private/tmp; do
  run TMUX_REAL="$_t/fake-tmux" TMUX="$_live" TMUX_PANE=%3 \
    TMUX_TMPDIR="$_d" "$_shim" display -p x
  expect "TMUX_TMPDIR=$_d keeps TMUX" "$_live|%3"
done

# Real tmux in a temp socket dir: one server for every session.
_rt() {
  env -u TMUX TMUX_TMPDIR="$_t/s" TMUX_REAL="$_realtmux" "$_shim" "$@"
}
mkdir -p "$_t/r/.worktrees/abc-1"
_rt new-session -d -s abc-1 -c "$_t/r/.worktrees/abc-1" 'sleep 60' \
  2>"$_t/err" \
  || _no "real new-session" "$(cat "$_t/err")"
_rt new-session -d -s mine -c "$_t" 'sleep 60' 2>/dev/null
test "$(_rt ls -F '#S' | sort | tr '\n' ' ')" = "abc-1 mine " \
  && _ok "worktree and own sessions share default" \
  || _no "one server" "$(_rt ls -F '#S' 2>&1)"
test "$(ls "$_t/s/tmux-$_uid")" = default \
  && _ok "no other socket" || _no "no other socket" "$(ls "$_t/s/tmux-$_uid")"
_p="$(_rt display -p -t =abc-1: '#{pane_id}')"
case "$_p" in %[0-9]*) _ok "pane_id is bare ($_p)" ;;
  *) _no "pane_id is bare" "$_p" ;; esac
_rt display -p -t "$_p@default" '#S' | grep -qx abc-1 \
  && _ok "real %N@default target resolves" \
  || _no "real %N@default target" "$(_rt display -p -t "$_p@default" '#S' 2>&1)"

# From inside a pane of a "live" server, a fresh TMUX_TMPDIR reaches its
# own server, and its kill-server leaves the live one up.
_lt() { env TMUX_TMPDIR="$_t/live" "$_realtmux" "$@"; }
_lt new-session -d -s agent 'sleep 60'
_livetmux="$(_lt display -p -t agent: '#{socket_path},#{pid},0')"
_livepid="$(_lt display -p '#{pid}')"
_in() {
  env TMUX="$_livetmux" TMUX_PANE=%0 TMUX_TMPDIR="$_t/s" \
    TMUX_REAL="$_realtmux" "$_shim" "$@"
}
_sock="$(_in display -p '#{socket_path}' 2>&1)"
case "$_sock" in
  "$_sd"/*) _ok "display from a live pane answers from TMUX_TMPDIR" ;;
  *) _no "display from a live pane" "answered from $_sock" ;;
esac
_spid="$(_rt display -p '#{pid}')"
_in kill-server 2>/dev/null
test "$(_lt display -p '#{pid}' 2>/dev/null)" = "$_livepid" \
  && _ok "kill-server from a live pane spares the live server" \
  || _no "live server survives" "pid now '$(_lt display -p '#{pid}' 2>&1)'"
# kill-server returns before the server is gone. (tpm's background run
# may start a fresh one there: only this pid counts.)
_i=0
while kill -0 "$_spid" 2>/dev/null && test "$_i" -lt 20; do
  sleep 0.1; _i=$((_i + 1))
done
kill -0 "$_spid" 2>/dev/null \
  && _no "TMUX_TMPDIR server killed" "pid $_spid still up" \
  || _ok "kill-server hit the TMUX_TMPDIR server"

exit "$_fail"
