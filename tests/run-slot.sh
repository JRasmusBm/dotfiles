#!/bin/sh
#
# tests/run-slot.sh [BIN] — scenarios for bin/run-slot and bin/wt-tell
# against a throwaway tmux server and a fake `claude` (RAS-20: a chat
# revived for a tell gets it and is not closed first). Nothing real is
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
  RUN_SLOT_PRESSURE=1 RUN_SLOTS=12 TMUX_AGENT_SHARDS=0
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
  rm -rf "$LOCAL_CONFIG" "$CLAUDE_CONFIG_DIR" "$_t/w/.worktrees/.worktrees" "$FAKE/notify"
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
_check "hold: a lapsed hold is held again, still first" \
  'grep -q "	c	0$" "$_rs/reserved" \
    && test "$(head -1 "$_rs/queue" | cut -f3)" = c'
_check "hold: c uses its slot and leaves the queue" \
  'test "$(_g start c)" = 0 && test "$(cut -f3 "$_rs/queue")" = d'

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

echo "$_pass passed, $_fail failed"
test "$_fail" = 0
