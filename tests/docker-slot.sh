#!/bin/sh
#
# tests/docker-slot.sh [SCRIPT] — scenarios for bin/docker-slot's
# reap and prune against fake docker, tmux and pgrep. Nothing real
# is touched: LOCAL_CONFIG is a temp dir, the fakes come first on
# PATH. macOS only (BSD date, like docker-slot). SCRIPT defaults to
# this checkout's bin/docker-slot; pass another to compare.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_slot="${1:-$_root/bin/docker-slot}"
_t="$(mktemp -d)"
trap 'rm -rf "$_t"' EXIT
export FAKE="$_t/fake" LOCAL_CONFIG="$_t/cfg"
mkdir -p "$FAKE/bin"

# docker: rows in st/ps (id|owner label|name|compose project|compose
# dir|state|image, id = name); removals, stops and quits in calls.
cat > "$FAKE/bin/docker" <<'X'
#!/bin/sh
st="$FAKE/st"
case "$1" in
  info) test -f "$st/up"; exit ;;
  ps) cat "$st/ps" 2>/dev/null ;;
  rm) eval "n=\${$#}"; echo "rm $n" >> "$FAKE/calls"
    awk -F'|' -v n="$n" '$1 != n' "$st/ps" > "$st/ps.n"
    mv "$st/ps.n" "$st/ps" ;;
  stop) echo "stop $2" >> "$FAKE/calls"
    awk -F'|' -v OFS='|' -v n="$2" '$1 == n { $6 = "exited" } 1' \
      "$st/ps" > "$st/ps.n"
    mv "$st/ps.n" "$st/ps" ;;
  inspect) echo 2020-01-01T00:00:00Z ;;
  desktop) test "$2" != stop || { echo quit >> "$FAKE/calls"; rm -f "$st/up"; } ;;
esac
exit 0
X
# tmux: st/notmux = no process (pgrep fails too), st/hung = a server
# that doesn't answer; else st/sessions.
cat > "$FAKE/bin/tmux" <<'X'
#!/bin/sh
test ! -f "$FAKE/st/notmux" && test ! -f "$FAKE/st/hung" || exit 1
test "$1" = list-sessions && cat "$FAKE/st/sessions"
X
cat > "$FAKE/bin/pgrep" <<'X'
#!/bin/sh
case "$*" in *tmux*) test ! -f "$FAKE/st/notmux" ;; *) exit 1 ;; esac
X
for _c in curl:1 sleep:0 osascript:0 footprint:0; do
  printf '#!/bin/sh\nexit %s\n' "${_c#*:}" > "$FAKE/bin/${_c%:*}"
done
chmod +x "$FAKE/bin"/*
export PATH="$FAKE/bin:$PATH" DOCKER_SLOT_GRACE=0
unset TMUX_PANE CLAUDECODE DOCKER_SLOT_OWNER

_d="$LOCAL_CONFIG/docker-slot"
_now="$(date +%s)"
_pass=0 _fail=0

# _given: fresh state, Docker up, prune not due, sessions "other".
_given() {
  rm -rf "$LOCAL_CONFIG" "$FAKE/st" "$FAKE/calls"
  mkdir -p "$FAKE/st" "$_d/in" "$_d/agent" "$_d/tmux"
  : > "$FAKE/st/up"
  : > "$FAKE/st/ps"
  : > "$FAKE/calls"
  echo other > "$FAKE/st/sessions"
  echo "$_now" > "$_d/last-prune"
}
_row() { echo "$1|$2|$1|||$3|img" >> "$FAKE/st/ps"; }
# _agent OWNER: an agent last seen in its own tmux session.
_agent() { echo tmux > "$_d/agent/$1"; : > "$_d/tmux/$1"; }
_in() { echo "$((_now + $2))" > "$_d/in/$1"; }
_reap() { "$_slot" reap >/dev/null 2>&1; }

# _then NAME [has|lacks LINE]...: check the calls log.
_then() {
  _n="$1" _ok=1
  shift
  while test $# -gt 0; do
    _h=0
    grep -qxF "$2" "$FAKE/calls" && _h=1
    case "$1$_h" in has0|lacks1) _ok=''; _why="$1 '$2'" ;; esac
    shift 2
  done
  if test -n "$_ok"; then _pass=$((_pass + 1)); echo "ok   $_n"
  else
    _fail=$((_fail + 1))
    echo "FAIL $_n: $_why; calls: $(tr '\n' ';' < "$FAKE/calls")"
  fi
}

_given; : > "$FAKE/st/notmux"; _agent a; _in a -60
_row a a running
_reap
_then "no tmux, agent DB running, check-in expired: kept, Docker quits" \
  lacks 'rm a' has quit
test ! -f "$_d/in/a" || _then "  ... and the check-in ends" has never

_given; : > "$FAKE/st/notmux"; _agent a; _in a 600
_row a a running
_reap
_then "no tmux, agent checked in: kept, Docker stays" \
  lacks 'rm a' lacks quit
test -f "$_d/in/a" || _then "  ... and the check-in stays" has never

_given; : > "$FAKE/st/notmux"; _agent a
_row a a exited
_reap
_then "no tmux, stopped DB of an owner last seen in tmux: kept" \
  lacks 'rm a' has quit

_given; : > "$FAKE/st/notmux"; _row x '' running
_reap
_then "no tmux, unowned container: not stopped, Docker quits" \
  lacks 'stop x' has quit

_given; : > "$FAKE/st/notmux"; _agent a; _in a -60
_row a a running
_reap; _reap
rm "$FAKE/st/notmux"; echo a > "$FAKE/st/sessions"; : > "$FAKE/st/up"
_reap
_then "tmux back with the session: its DB kept" lacks 'rm a'
test -f "$_d/agent/a" || _then "  ... and its agent mark" has never

_given; : > "$FAKE/st/notmux"; _agent a
_row a a exited
rm -f "$_d/last-prune"
_reap
_then "no tmux, prune: a stopped DB of an owner last seen in tmux stays" \
  lacks 'rm a'

_given; _agent a; _in a -60
_row a a running
_reap
_then "tmux answers, owner gone: removed" has 'rm a'

_given; echo a > "$FAKE/st/sessions"; _agent a; _in a -60
_row a a running
_reap
_then "tmux answers, agent's session lives: kept, Docker stays" \
  lacks 'rm a' lacks quit

_given; : > "$FAKE/st/hung"; _agent a; _in a -60
_row a a running
_reap
_then "tmux hung, agent DB running: kept, Docker stays" \
  lacks 'rm a' lacks quit

_given; : > "$FAKE/st/hung"; _agent a
_row a a exited
_reap
_then "tmux hung, nothing running: kept, Docker quits" \
  lacks 'rm a' has quit

_given; _in u -60
_row u u running
_reap
_then "human check-in expired: removed (TTL, not tmux)" has 'rm u'

echo "$_pass passed, $_fail failed"
test "$_fail" = 0
