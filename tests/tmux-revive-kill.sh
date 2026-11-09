#!/bin/sh
#
# tests/tmux-revive-kill.sh — a stub server kill, end to end: real
# tmux servers in a temp socket dir, the shim placing 30 chats (20
# mid-turn, 10 idle) on agents-1/agents-2, and the real tmux-watch,
# tmux-revive, run-slot and claude-pane; only `claude` is a fake that
# takes FAKE_BOOT seconds to start. Two scenarios:
#   slice  agents-1 is SIGKILLed: its chats come back, agents-2's and
#          my default session are untouched.
#   all30  both agents servers are SIGKILLed at once: timed from the
#          kill to the last mid-turn chat resumed and told to carry
#          on (bar: 300 s), mid-turn ones admitted before any idle one
#          is parked, every idle one parked and resumable by focus.
# Prints the timings; needs cc. Nothing real is touched.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_t="$(mktemp -d /tmp/trk.XXXX)"
unset TMUX TMUX_PANE TMUX_SERVER RUN_SLOT_ID
export TMUX_TMPDIR="$_t/s" LOCAL_CONFIG="$_t/cfg" CLAUDE_CONFIG_DIR="$_t/cc" \
  FAKE="$_t/fake" TMUX_AGENT_SHARDS=2 TMUX_WATCH_ENV=inherit \
  TMUX_WATCH_TICK=0.2 TMUX_WATCH_SNAPSHOT_EVERY=2 RUN_SLOT_FREE_GB=100 \
  RUN_SLOT_PRESSURE=2 RUN_SLOTS=12 FAKE_BOOT="${FAKE_BOOT:-2}" \
  SHELL=/bin/sh ENV=
export PATH="$FAKE/bin:$_root/shims:$_root/bin:$PATH"
mkdir -p "$TMUX_TMPDIR" "$FAKE/bin"
_w=""
_stop() {
  test -z "$_w" || kill "$_w" 2>/dev/null
  test -z "$_w" || wait "$_w" 2>/dev/null
  _w=""
  for _s in default agents-1 agents-2; do
    tmux -L "$_s" kill-server 2>/dev/null
  done
}
test -n "${KEEP:-}" || trap '_stop; rm -rf "$_t"' EXIT

cat > "$FAKE/claude.c" <<'X'
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
int main(int c, char **v) {
  char *a[c + 3];
  a[0] = "/bin/zsh"; a[1] = "-f"; a[2] = getenv("FAKE_ZSH");
  for (int i = 1; i < c; i++) a[i + 2] = v[i];
  a[c + 2] = 0;
  pid_t p = fork();
  if (!p) { execv(a[0], a); _exit(127); }
  int s; waitpid(p, &s, 0); return 0;
}
X
cc -o "$FAKE/bin/claude" "$FAKE/claude.c" || exit 1
export FAKE_ZSH="$FAKE/claude.zsh"
# A resume boots for FAKE_BOOT s, then shows an empty prompt; a fresh
# start with $PWD/.work shows the spinner. Logs argv and lines typed,
# with the time, to $PWD/.got.
cat > "$FAKE_ZSH" <<'X'
zmodload zsh/datetime
sid="${FAKE_SID:-}"
test "${1:-}" = --resume && { sid="$2"; sleep "$FAKE_BOOT"; }
w="$(tmux display-message -p -t "$TMUX_PANE" '#S:#{window_id}')"
printf '{"sessionId":"%s","cwd":"%s","tmux":"%s.%s","status":"idle"}\n' \
  "$sid" "$PWD" "$w" "$TMUX_PANE" > "$CLAUDE_CONFIG_DIR/sessions/$$.json"
echo "argv $EPOCHREALTIME $*" >> .got
idle() { printf '\n❯ \n-- INSERT --\n'; }
if test -z "${1:-}" && test -f .work; then
  echo '✻ Cogitating… (3s · esc to interrupt)'
else idle
fi
while read -r l; do echo "said $EPOCHREALTIME $l" >> .got; idle; done
X
printf '#!/bin/sh\necho "$*" >> "$FAKE/notify"\n' > "$FAKE/bin/notify"
printf '#!/bin/sh\nexit 1\n' > "$FAKE/bin/source_tmux_script"
cat > "$FAKE/bin/default_tmux_session" <<'X'
#!/bin/sh
tmux new-session -d -s "$TMUX_SESSION_NAME" -n cli -c "$PWD" /bin/sh
X
chmod +x "$FAKE/bin/"*

_pass=0 _fail=0
_ok() { _pass=$((_pass + 1)); echo "ok   $1"; }
_no() { _fail=$((_fail + 1)); echo "FAIL $1"; }
_check() { if eval "$2"; then _ok "$1"; else _no "$1"; fi; }
_nap() { perl -e "select undef, undef, undef, $1"; }
_until() {
  _n=0
  until eval "$1"; do
    _n=$((_n + 1)); test "$_n" -lt "$2" || return 1; _nap 0.25
  done
}
_now() { perl -MTime::HiRes=time -e 'printf "%.2f", time'; }
_r="$_t/r/.worktrees"
_srv() { cat "$LOCAL_CONFIG/tmux-home/$1"; }
_told() { grep -c '^said [0-9.]* tmux restarted at' "$_r/$1/.got" 2>/dev/null; }
_resumed() { grep -c '^argv [0-9.]* --resume' "$_r/$1/.got" 2>/dev/null; }

# _given: a fresh world, tmux-watch up, 30 chats (c01-c20 mid-turn),
# my own session `mine` on default, every snapshot taken.
_given() {
  _stop
  rm -rf "$LOCAL_CONFIG" "$CLAUDE_CONFIG_DIR" "$_t/r" "$FAKE/notify"
  mkdir -p "$LOCAL_CONFIG" "$CLAUDE_CONFIG_DIR/sessions"
  "$_root/bin/tmux-watch" >/dev/null 2>&1 & _w=$!
  _until 'tmux -L agents-2 display -p x >/dev/null 2>&1' 40
  tmux -L default new-session -d -s mine -c "$_t" /bin/sh
  _i=1
  while test "$_i" -le 30; do
    _c="c$(printf %02d "$_i")"
    mkdir -p "$_r/$_c"
    test "$_i" -gt 20 || : > "$_r/$_c/.work"
    tmux new-session -d -s "$_c" -n cli -c "$_r/$_c" \
      "FAKE_SID=s$_c exec $FAKE/bin/claude"
    _i=$((_i + 1))
  done
  _until 'test "$(claude-pane map | wc -l)" -ge 30' 80
  _until 'test "$(cat "$LOCAL_CONFIG"/tmux-revive.snapshot.agents-* \
    2>/dev/null | grep -c "	1$")" = 20' 80
  _mine="$(tmux -L default display -p '#{pid}') $(tmux display -p \
    -t =mine: '#{pane_pid}')"
}

_quiet() {
  ! test -s "$LOCAL_CONFIG/tmux-revive.queue" && test -s "$FAKE/notify"
}

# --- slice: one agents server dies
_given
_a1="$(cd "$LOCAL_CONFIG/tmux-home" && grep -lx agents-1 c* | tr '\n' ' ')"
_a2="$(cd "$LOCAL_CONFIG/tmux-home" && grep -lx agents-2 c* | tr '\n' ' ')"
_check "slice: the shim spread the chats over both agents servers" \
  'test -n "$_a1" && test -n "$_a2" && test -z "$(ls "$LOCAL_CONFIG/tmux-home" \
    | grep -v "^c")"'
_t0="$(_now)"
kill -9 "$(tmux -L agents-1 display -p '#{pid}')"
_until _quiet 1200
_t1="$(_now)"
_hot=0 _back=0 _park=0
for _c in $_a1; do
  if test -f "$_r/$_c/.work"; then
    _hot=$((_hot + 1))
    test "$(_resumed "$_c")" = 1 && test "$(_told "$_c")" = 1 \
      && _back=$((_back + 1))
  else
    grep -q "	$_c	" "$LOCAL_CONFIG/run-slots/closed" && _park=$((_park + 1))
  fi
done
_n1="$(echo $_a1 | wc -w | tr -d ' ')"
_check "slice: agents-1's $_hot mid-turn chats resumed and told, the \
other $((_n1 - _hot)) parked ($(echo "$_t1 - $_t0" | bc)s)" \
  'test "$_back" = "$_hot" && test "$((_back + _park))" = "$_n1"'
_same=1
for _c in $_a2; do
  test "$(_resumed "$_c")" = 0 && test "$(_told "$_c")" = 0 || _same=0
done
_check "slice: agents-2's chats untouched" 'test "$_same" = 1'
_check "slice: my default server and pane untouched" \
  'test "$(tmux -L default display -p "#{pid}") $(tmux display -p \
    -t =mine: "#{pane_pid}")" = "$_mine"'
_check "slice: the ping names the cause" \
  'grep -q "cause .*agents-1: killed by SIGKILL" "$FAKE/notify"'

# --- all30: both agents servers die at once
_given
_t0="$(_now)"
kill -9 "$(tmux -L agents-1 display -p '#{pid}')" \
  "$(tmux -L agents-2 display -p '#{pid}')"
_hotdone() {
  _k=0
  for _c in $(cd "$_r" && ls); do
    test -f "$_r/$_c/.work" && test "$(_told "$_c")" = 1 && _k=$((_k + 1))
  done
  test "$_k" = 20
}
if _until _hotdone 1200; then
  _t1="$(_now)"
  _dt="$(echo "$_t1 - $_t0" | bc)"
  _check "all30: the 20 mid-turn chats resumed and told in ${_dt}s \
(bar 300s, boot ${FAKE_BOOT}s each)" 'test "${_dt%.*}" -lt 300'
else
  _no "all30: the 20 mid-turn chats resumed and told within 300s"
fi
_until _quiet 400
_l="$LOCAL_CONFIG/run-slots/run-slot.log"
_last="$(grep -n '	admit	revive:.*	revive$' "$_l" | tail -1 | cut -d: -f1)"
_first="$(grep -n '	park	' "$_l" | head -1 | cut -d: -f1)"
_check "all30: every mid-turn chat admitted (past the cap of 12) before \
the first idle one parked" \
  'test "$(grep -c "	admit	revive:.*	revive$" "$_l")" = 20 \
    && test -n "$_first" && test "$_last" -lt "$_first"'
_check "all30: the 10 idle chats parked as closed" \
  'test "$(grep -c "	closed$" "$LOCAL_CONFIG/run-slots/closed")" = 10'
_p="$(tmux display -p -t =c25:cli '#{pane_id}')"
run-slot focus "$_p" >/dev/null
_until 'test "$(_resumed c25)" = 1' 40
_check "all30: focusing a parked chat's pane resumes it" \
  'test "$(_resumed c25)" = 1'
_check "all30: my default pane untouched" \
  'test "$(tmux display -p -t =mine: "#{pane_pid}")" = "${_mine#* }"'
_check "all30: one ping sums it up" \
  'test "$(wc -l < "$FAKE/notify" | tr -d " ")" = 1 && grep -q \
    "revived 20 Claude chat(s), told 20 to carry on, 10 idle ones closed.*\
agents-1: killed by SIGKILL.*agents-2: killed by SIGKILL" "$FAKE/notify"'

test "$_fail" = 0 || cat "$FAKE/notify"
echo "$_pass passed, $_fail failed"
test "$_fail" = 0
