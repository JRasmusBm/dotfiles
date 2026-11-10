#!/bin/sh
#
# tests/tmux-revive-kill.sh — a stub server kill, end to end: real
# tmux server in a temp socket dir with 30 chats (20 mid-turn, 10
# idle), and the real shim, tmux-watch, tmux-revive, run-slot and
# claude-pane; only `claude` is a fake that takes FAKE_BOOT seconds to
# start. The server is SIGKILLed: timed from the kill to the last
# mid-turn chat resumed and told to carry on (bar: 300 s), mid-turn
# ones admitted before any idle one is parked, every idle one parked
# and resumable by focus.
# Prints the timings; needs cc. Nothing real is touched.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_t="$(mktemp -d /tmp/trk.XXXX)"
unset TMUX TMUX_PANE RUN_SLOT_ID
export TMUX_TMPDIR="$_t/s" LOCAL_CONFIG="$_t/cfg" CLAUDE_CONFIG_DIR="$_t/cc" \
  FAKE="$_t/fake" TMUX_WATCH_ENV=inherit \
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
  tmux -L default kill-server 2>/dev/null
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
_told() { grep -c '^said [0-9.]* tmux restarted at' "$_r/$1/.got" 2>/dev/null; }
_resumed() { grep -c '^argv [0-9.]* --resume' "$_r/$1/.got" 2>/dev/null; }

# _given: a fresh world, tmux-watch up, 30 chats (c01-c20 mid-turn),
# the snapshot taken.
_given() {
  _stop
  rm -rf "$LOCAL_CONFIG" "$CLAUDE_CONFIG_DIR" "$_t/r" "$FAKE/notify"
  mkdir -p "$LOCAL_CONFIG" "$CLAUDE_CONFIG_DIR/sessions"
  "$_root/bin/tmux-watch" >/dev/null 2>&1 & _w=$!
  _until 'tmux -L default display -p x >/dev/null 2>&1' 40
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
  _until 'test "$(grep -c "	1$" "$LOCAL_CONFIG/tmux-revive.snapshot" \
    2>/dev/null)" = 20' 80
}

_quiet() {
  ! test -s "$LOCAL_CONFIG/tmux-revive.queue" && test -s "$FAKE/notify"
}

# --- all30: the server dies
_given
_t0="$(_now)"
kill -9 "$(tmux -L default display -p '#{pid}')"
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
_check "all30: one ping sums it up" \
  'test "$(wc -l < "$FAKE/notify" | tr -d " ")" = 1 && grep -q \
    "revived 20 Claude chat(s), told 20 to carry on, 10 idle ones closed.*\
default: killed by SIGKILL" "$FAKE/notify"'

test "$_fail" = 0 || cat "$FAKE/notify"
echo "$_pass passed, $_fail failed"
test "$_fail" = 0
