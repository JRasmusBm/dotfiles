#!/bin/sh
#
# tests/run-slot.sh [BIN] — scenarios for bin/run-slot and bin/wt-tell
# against a throwaway tmux server and a fake `claude` (RAS-20: a chat
# revived for a tell gets it and is not closed first; RAS-28: only its
# deadline tell ends a wt w8). Nothing real is
# touched: TMUX_TMPDIR, LOCAL_CONFIG and CLAUDE_CONFIG_DIR are a temp
# dir, the fakes come first on PATH. Needs cc. BIN defaults to this
# checkout's bin/ (point it at another checkout's to compare).

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_bin="${1:-$_root/bin}"
_t="$(mktemp -d /tmp/rst.XXXX)"
unset TMUX TMUX_PANE RUN_SLOT_ID RUN_SLOT_PENDING
export TMUX_TMPDIR="$_t/s" LOCAL_CONFIG="$_t/cfg" \
  CLAUDE_CONFIG_DIR="$_t/cc" FAKE="$_t/fake" RUN_SLOT_FREE_GB=100 \
  RUN_SLOT_PRESSURE=1 RUN_SLOTS=12
test -n "${KEEP:-}" || trap 'tmux kill-server 2>/dev/null; rm -rf "$_t"' EXIT
mkdir -p "$TMUX_TMPDIR" "$FAKE/bin"
export PATH="$FAKE/bin:$_root/shims:$_bin:$PATH"
# Panes run /bin/sh, whose PATH no shell rc reorders: run-slot types a
# bare `claude`, which must be the fake.
export SHELL=/bin/sh ENV=
_rs="$LOCAL_CONFIG/run-slots"

# claude: forks the zsh below, so tmux shows `claude` as the pane's
# command. It writes its session file (startedAt now, or $FAKE_STARTED
# ms), logs argv and each line typed to $PWD/.got, shows an empty
# prompt only once $PWD/.ready exists (Claude still starting) and
# exits on /exit.
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
cat > "$FAKE_ZSH" <<'X'
sid="${FAKE_SID:-}"
test "${1:-}" = --resume && sid="$2"
w="$(tmux display-message -p -t "$TMUX_PANE" '#S:#{window_id}')"
{
  printf '{"sessionId":"%s","cwd":"%s","tmux":"%s.%s",' "$sid" "$PWD" "$w" \
    "$TMUX_PANE"
  printf '"startedAt":%s,"status":"idle"}\n' \
    "${FAKE_STARTED:-$(($(date +%s) * 1000))}"
} > "$CLAUDE_CONFIG_DIR/sessions/$$.json"
echo "argv $*" >> .got
until test -f .ready; do sleep 0.2; done
idle() { printf '\n❯ \n-- INSERT --\n'; }
idle
while read -r l; do
  test "$l" = /exit && exit
  echo "said $l" >> .got; idle
done
X
for _c in notify notif; do
  printf '#!/bin/sh\necho "$*" >> "$FAKE/%s"\n' "$_c" > "$FAKE/bin/$_c"
done
chmod +x "$FAKE/bin/"*

_pass=0 _fail=0
_ok() { _pass=$((_pass + 1)); echo "ok   $1"; }
_no() { _fail=$((_fail + 1)); echo "FAIL $1"; }
_check() { if eval "$2"; then _ok "$1"; else _no "$1"; fi; }
_wait() {
  _n=0
  until eval "$1" || test "$_n" -ge 40; do
    _n=$((_n + 1)); perl -e 'select undef, undef, undef, 0.25'
  done
}

_given() {
  tmux kill-server 2>/dev/null
  rm -rf "$LOCAL_CONFIG" "$CLAUDE_CONFIG_DIR" "$_t/w/.worktrees/.worktrees" \
    "$FAKE/notify" "$FAKE/notif"
  mkdir -p "$_rs" "$LOCAL_CONFIG/worktrees" "$CLAUDE_CONFIG_DIR/sessions" \
    "$CLAUDE_CONFIG_DIR/projects/p" "$_t/w/.worktrees/.worktrees"
  tmux -f /dev/null new-session -d -s _ /bin/sh
}

# _transcript SID: its last turn ended 64 hours ago, on no question.
_transcript() {
  _at="$(date -u -r $(($(date +%s) - 230400)) +%Y-%m-%dT%H:%M:%S)"
  printf '%s\n' \
    "{\"type\":\"user\",\"timestamp\":\"$_at.000Z\",\"message\":{}}" \
    "{\"type\":\"assistant\",\"timestamp\":\"$_at.000Z\",$(
      )\"message\":{\"content\":[{\"type\":\"text\",$(
      )\"text\":\"Done.\"}]}}" \
    > "$CLAUDE_CONFIG_DIR/projects/p/$1.jsonl"
}

# _closed NAME: run-slot closed NAME's Claude 64 hours ago; its cli
# pane is a shell now.
_closed() {
  mkdir -p "$_t/w/.worktrees/$1"
  tmux new-session -d -s "$1" -n cli -c "$_t/w/.worktrees/$1" /bin/sh
  _p="$(tmux display-message -p -t "=$1:cli" '#{pane_id}')"
  _transcript "s$1"
  printf '%s\ts%s\t%s\t%s\t%s\t1000\t%s\tclosed\n' "$(date +%s)" "$1" \
    "$_p" "$1" "$_t/w/.worktrees/$1" "$(($(date +%s) - 230400))" >> "$_rs/closed"
  echo "$_p"
}

# _open NAME: a Claude that started (and last spoke) 64 hours ago.
_open() {
  mkdir -p "$_t/w/.worktrees/$1"; : > "$_t/w/.worktrees/$1/.ready"
  _transcript "s$1"
  tmux new-session -d -s "$1" -n cli -c "$_t/w/.worktrees/$1" \
    "FAKE_SID=s$1 FAKE_STARTED=$((($(date +%s) - 230400) * 1000)) \
exec $FAKE/bin/claude"
}

_up() { test -n "$(grep -l "\"s$1\"" "$CLAUDE_CONFIG_DIR"/sessions/*.json \
  2>/dev/null)"; }
_cmd() { tmux display-message -p -t "=$1:cli" '#{pane_current_command}'; }
_said() { grep -c "^said $2\$" "$_t/w/.worktrees/$1/.got" 2>/dev/null; }
_tell() {
  wt-tell "$_t/w/.worktrees/pla" deployed:production:9073 "#9073 on production" \
    "PR 9073 is on production"
}

# --- replay of 10:41/10:45: a tell revives the chat, Claude is still
# starting when wt-tell would type, then close runs
_given
_closed pla >/dev/null
_tell; _rc=$?
_wait '_up pla'
_check "tell: wt-tell revives the closed chat by its session id" \
  'grep -qx "argv --resume spla" "$_t/w/.worktrees/pla/.got"'
_check "tell: handed to run-slot (exit 0), not yet told" \
  'test "$_rc" = 0 && ! grep -q deployed "$LOCAL_CONFIG/wt-told" 2>/dev/null'
_check "tell: run-slot ls shows it pending" \
  'run-slot ls | grep -q "^pending	tell:pla:deployed:production:9073	"'
run-slot pump >/dev/null
_check "tell: Claude still starting, the pump keeps it pending" \
  'test "$(_said pla "PR 9073 is on production")" = 0 \
    && run-slot ls | grep -q "^pending	tell:pla:"'
run-slot close >/dev/null
_check "close: a chat revived minutes ago is not closed, 64h idle or not" \
  'test "$(_cmd pla)" = claude \
    && run-slot close -n -v | grep -q "^keep	pla	started 0m ago"'
# Two minutes on: the revive's reservation is over, Claude is ready.
: > "$_rs/reserved"; : > "$_t/w/.worktrees/pla/.ready"
_wait 'claude-pane-idle "$(tmux display-message -p -t =pla:cli "#{pane_id}")"'
_check "close: a pending tell keeps it open past the start grace" \
  'RUN_SLOT_CLOSE_MIN=0 run-slot close -n -v \
    | grep -q "^keep	pla	tell on its way (tell:pla:deployed"'
run-slot pump >/dev/null
_wait 'test "$(_said pla "PR 9073 is on production")" = 1'
_check "tell: delivered once Claude is ready, recorded as told" \
  'test "$(_said pla "PR 9073 is on production")" = 1 \
    && grep -qx "$_t/w/.worktrees/pla	deployed:production:9073" \
      "$LOCAL_CONFIG/wt-told"'
_check "tell: no longer pending" '! run-slot ls | grep -q "^pending"'
run-slot pump >/dev/null; _tell
_check "tell: told once, however often it runs again" \
  'test "$(_said pla "PR 9073 is on production")" = 1'
# The tell's reservation over too: only the start grace is left.
: > "$_rs/reserved"
RUN_SLOT_CLOSE_MIN=0 run-slot close >/dev/null
_wait 'test "$(_cmd pla)" != claude'
_check "close: once told and idle, the rule closes it again" \
  'test "$(_cmd pla)" != claude && grep -q "	close	spla	" "$_rs/run-slot.log"'

# --- focus: I focus a closed pane, it is revived, close runs
_given
_p="$(_closed foc)"; : > "$_t/w/.worktrees/foc/.ready"
run-slot focus "$_p" >/dev/null
_wait '_up foc'
_wait 'claude-pane-idle "$_p"'
run-slot close >/dev/null
_check "focus: a chat revived on focus is not closed a minute later" \
  'test "$(_cmd foc)" = claude \
    && run-slot close -n -v | grep -q "^keep	foc	started 0m ago"'

# --- control: started and idle 64 hours ago, nothing on its way
_given
_open old; _wait '_up old'
_wait 'claude-pane-idle "$(tmux display-message -p -t =old:cli "#{pane_id}")"'
_check "control: an old idle chat is still a close candidate" \
  'run-slot close -n | grep -q "^close	old	"'

# --- w8: an open (overdue) wt w8 keeps its chat up for the tell
printf 'old\tfeat/x\t2026-11-06T17:43\tCI on rebased #8918\t1793979805\n' \
  > "$LOCAL_CONFIG/worktrees/repo.waiting"
_check "w8: a chat whose worktree has a wt w8 is not closed" \
  'run-slot close -n -v | grep -q "^keep	old	wt w8 until 2026-11-06 17:43"'

# --- w8 tells (RAS-28): another tell leaves the agent's wt w8 open and
# reminds it; the deadline tell ends it and drops the overdue row
_given
_open wai; _wait '_up wai'
_wait 'claude-pane-idle "$(tmux display-message -p -t =wai:cli "#{pane_id}")"'
printf 'wai\tfeat/wai\t2999-01-01T14:32\tcheck pool after merge\t17\t%s\n' \
  "$_t/w" > "$LOCAL_CONFIG/worktrees/w.waiting"
wt-tell "$_t/w/.worktrees/wai" merged:620 "#620 merged" "PR 620 is merged." \
  >/dev/null
_wait 'test "$(_said wai "PR 620 is merged.*")" = 1'
_check "w8: a merge tell leaves the w8 row in place" \
  'grep -q "^wai	" "$LOCAL_CONFIG/worktrees/w.waiting"'
_check "w8: the merge tell says what the w8 waits on, until when, wt ip" \
  'grep -qxF "said PR 620 is merged. Your wt w8 is still open: check pool \
after merge, until 2999-01-01 14:32. If this tell was that event, run wt w8 \
done; else it stays open." "$_t/w/.worktrees/wai/.got"'
_check "w8: the merge tell leaves the overdue inbox row" \
  '! grep -q seen-ref "$FAKE/notif" 2>/dev/null'
# Its deadline passed, its own tell still queued (Claude was busy).
sed -i '' 's/2999-01-01T14:32/2020-11-09T14:32/' \
  "$LOCAL_CONFIG/worktrees/w.waiting"
wt-tell "$_t/w/.worktrees/wai" ci:abc "CI red" "CI failed on abc." >/dev/null
_wait 'test "$(_said wai "CI failed on abc.*")" = 1'
_check "w8: past its deadline a tell says the w8 is overdue, check now" \
  'grep -qxF "said CI failed on abc. Your wt w8 is overdue (since \
2020-11-09 14:32): check pool after merge. Check on it now. If this tell was \
that event, run wt w8 done; else it stays open." "$_t/w/.worktrees/wai/.got"'
wt-tell "$_t/w/.worktrees/wai" w8:wai:17 "Overdue: wai" \
  "Your wt w8 deadline passed." >/dev/null
_wait 'test "$(_said wai "Your wt w8 deadline passed.")" = 1'
_check "w8: the deadline tell is told as is, no reminder" \
  'test "$(grep -c "deadline passed.*w8 done" "$_t/w/.worktrees/wai/.got")" = 0'
_check "w8: the deadline tell ends the w8" \
  '! grep -q "^wai	" "$LOCAL_CONFIG/worktrees/w.waiting"'
_check "w8: the deadline tell drops the overdue inbox row" \
  'grep -qx "seen-ref w/wai" "$FAKE/notif"'
wt-tell "$_t/w/.worktrees/wai" deployed:620 "#620 live" "PR 620 is live." \
  >/dev/null
_wait 'test "$(_said wai "PR 620 is live.")" = 1'
_check "w8: with no w8 open a tell is told as is" \
  'test "$(grep -c "^said PR 620 is live" "$_t/w/.worktrees/wai/.got")" = 1'
_check "w8: a pinged tell (worktree gone) leaves the w8 too" '
  printf "gon\tfeat/gon\t2026-11-09T14:32\tx\t18\n" \
    >> "$LOCAL_CONFIG/worktrees/w.waiting"
  WT_TELL_NO_REVIVE=1 wt-tell "$_t/w/.worktrees/gon" merged:7 "#7 merged" \
    "PR 7 is merged." >/dev/null
  grep -q "#7 merged" "$FAKE/notify" \
    && grep -q "^gon	" "$LOCAL_CONFIG/worktrees/w.waiting"'

# --- expiry: a pending tell is dropped after 3 days
_given
printf '%s\ttell:gone:k\t["false"]\n' "$(($(date +%s) - 260000))" \
  > "$_rs/pending"
run-slot pump >/dev/null
_check "expiry: a 3-day-old pending tell is dropped and logged" \
  'test ! -s "$_rs/pending" && grep -q "	drop	tell:gone:k	" \
    "$_rs/run-slot.log"'

# --- gate: a revive goes past the cap, a hold keeps its place
_given
_g() { RUN_SLOTS=1 run-slot gate "$1" "$2" -- >/dev/null 2>&1; echo $?; }
_check "gate: the first start takes the one slot" 'test "$(_g start a)" = 0'
_check "gate: the next start waits on the cap" 'test "$(_g start c)" = 75'
_g start d >/dev/null
_check "gate: a revive goes past the cap" 'test "$(_g revive r)" = 0'
: > "$_rs/reserved"
RUN_SLOTS=1 run-slot pump >/dev/null
_check "hold: the pump holds c's slot, c keeps its place in the queue" \
  'grep -q "	c	0$" "$_rs/reserved" \
    && cut -f3 "$_rs/queue" | tr "\n" " " | grep -qx "c d "'
_check "hold: d stays behind c's hold" 'test "$(_g start d)" = 75'
printf '%s\tc\t0\n' "$(($(date +%s) - 1))" > "$_rs/reserved"
RUN_SLOTS=1 run-slot pump >/dev/null
_check "hold: a lapsed hold is dropped, d gets the slot" \
  'grep -q "	drop	c	.*hold lapsed" "$_rs/run-slot.log" \
    && grep -q "	d	0$" "$_rs/reserved" \
    && test "$(cut -f3 "$_rs/queue")" = d'
_check "hold: c asking again queues behind d" \
  'test "$(_g start c)" = 75 \
    && cut -f3 "$_rs/queue" | tr "\n" " " | grep -qx "d c "'
_check "hold: d uses its slot and leaves the queue" \
  'test "$(_g start d)" = 0 && test "$(cut -f3 "$_rs/queue")" = c'

# --- wait: prints its place, goes once there is room
_given
printf '%s\tx\t1\n' "$(($(date +%s) + 600))" > "$_rs/reserved"
RUN_SLOTS=1 run-slot wait start w > "$_t/wait.out" 2>&1 &
_wp=$!
_wait 'grep -q queued "$_t/wait.out"'
_check "wait: shows its place and why" \
  'grep -qx "run-slot: queued, place 1 of 1 (1 working (cap 1); run-slot ls)" \
    "$_t/wait.out"'
: > "$_rs/reserved"
_wait '! kill -0 $_wp 2>/dev/null'
wait "$_wp"; _rc=$?
_check "wait: admitted once room frees, exit 0" \
  'test "$_rc" = 0 && grep -qx "run-slot: your turn" "$_t/wait.out"'
printf '%s\tx\t1\n' "$(($(date +%s) + 600))" > "$_rs/reserved"
RUN_SLOTS=1 run-slot wait start h > "$_t/wait.out" 2>&1 &
_wp=$!
_wait 'grep -q queued "$_t/wait.out"'
kill -HUP "$_wp"
wait "$_wp"
_check "wait: its pane closed, it leaves the queue" \
  '! grep -q "	h	" "$_rs/queue" && grep -q "	left	h	" "$_rs/run-slot.log"'

# --- needs-open: which chats a dead server's revive brings back now
_given
_transcript sold
_check "needs-open: an old idle chat with nothing on its way stays closed" \
  '! run-slot needs-open sold old >/dev/null'
_now="$(date -u +%Y-%m-%dT%H:%M:%S)"
printf '%s\n' "{\"type\":\"assistant\",\"timestamp\":\"$_now.000Z\",$(
  )\"message\":{\"content\":[{\"type\":\"text\",\"text\":\"Done.\"}]}}" \
  > "$CLAUDE_CONFIG_DIR/projects/p/snew.jsonl"
_check "needs-open: a turn that just ended comes back" \
  'run-slot needs-open snew new | grep -q "^turn ended 0m ago"'
printf 'old\tfeat/x\t2026-11-06T17:43\tCI\t1793979805\n' \
  > "$LOCAL_CONFIG/worktrees/repo.waiting"
_check "needs-open: an open wt w8 comes back" \
  'run-slot needs-open sold old | grep -q "^wt w8 until"'

# --- parked: an agent whose Bash only waits in the pool (RAS-31)
# parker(): Claude 1 runs a shell (2); its children are the cases.
_parked() {
  python3 - "$_bin/run-slot" "$@" <<'X'
import importlib.machinery, importlib.util, json, sys
l = importlib.machinery.SourceFileLoader('rs', sys.argv[1])
rs = importlib.util.module_from_spec(importlib.util.spec_from_loader('rs', l))
l.exec_module(rs)
ps = {1: (0, 'claude'), 2: (1, '/bin/zsh -c source shell-snapshots/s.sh')}
for i, c in enumerate(sys.argv[2:]):
    ps[10 + i] = (2, c)
with open(rs.POOL_STATE, 'w') as f:
    json.dump({'queue': [{'waiter': p} for p in ps if 'pool' in ps[p][1]]}, f)
sys.exit(0 if rs.parker(ps)(1) else 1)
X
}
mkdir -p "$LOCAL_CONFIG/pool"
_check "parked: queued in the pool behind | tail -30" \
  '_parked "pool take heavy 2" "tail -30"'
_check "parked: a CI watch behind | tee and grep" \
  '_parked "gh pr checks 1 --watch" "tee x.log" "/usr/bin/grep -v ok"'
_check "working: a shell running only tail -f" '! _parked "tail -f log"'
_check "working: a build behind | tail" '! _parked "yarn build" "tail -5"'

echo "$_pass passed, $_fail failed"
test "$_fail" = 0
