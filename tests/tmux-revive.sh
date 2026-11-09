#!/bin/sh
#
# tests/tmux-revive.sh [SCRIPT] — scenarios for bin/tmux-revive
# against a throwaway tmux server and a fake `claude`. Nothing real
# is touched: TMUX_TMPDIR, LOCAL_CONFIG and CLAUDE_CONFIG_DIR are a
# temp dir, the fakes come first on PATH. Needs cc (the fake claude
# is a binary so tmux shows `claude` as the pane's command), jq and
# macOS date. SCRIPT defaults to this checkout's bin/tmux-revive.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_rev="${1:-$_root/bin/tmux-revive}"
# Short: a tmux socket path must fit in 104 bytes.
_t="$(mktemp -d /tmp/trv.XXXX)"
unset TMUX TMUX_PANE
export TMUX_TMPDIR="$_t/s" LOCAL_CONFIG="$_t/cfg" \
  CLAUDE_CONFIG_DIR="$_t/cc" FAKE="$_t/fake"
test -n "${KEEP:-}" || trap 'tmux kill-server 2>/dev/null; rm -rf "$_t"' EXIT
mkdir -p "$TMUX_TMPDIR" "$FAKE/bin"
export PATH="$FAKE/bin:$_root/shims:$_root/bin:$PATH"

# claude: forks the zsh below. It writes the session file
# claude-pane reads, logs argv and each line typed to $PWD/.got, and
# shows the spinner when $PWD/.busy exists, or $PWD/.work on a fresh
# start; else an empty prompt in INSERT mode.
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
export FAKE_ZSH="$FAKE/claude.zsh" TMUX_REVIVE_CLAUDE="$FAKE/bin/claude"
cat > "$FAKE_ZSH" <<'X'
sid="${FAKE_SID:-}"
test "${1:-}" = --resume && sid="$2"
w="$(tmux display-message -p -t "$TMUX_PANE" '#S:#{window_id}')"
printf '{"sessionId":"%s","cwd":"%s","tmux":"%s.%s"}\n' \
  "$sid" "$PWD" "$w" "$TMUX_PANE" > "$CLAUDE_CONFIG_DIR/sessions/$$.json"
echo "argv $*" >> .got
idle() { printf '\n❯ \n-- INSERT --\n'; }
if test -f .busy || { test -z "${1:-}" && test -f .work; }; then
  echo '✻ Cogitating… (3s · esc to interrupt)'
else idle
fi
while read -r l; do echo "said $l" >> .got; idle; done
X
for _c in notify; do
  printf '#!/bin/sh\necho "$*" >> "$FAKE/%s"\n' "$_c" > "$FAKE/bin/$_c"
done
# run-slot: logs each call; needs-open gives $FAKE/open's reason for a
# sid listed there (`sid<TAB>reason`), else exit 1; a revive gate
# refuses while $FAKE/full exists.
cat > "$FAKE/bin/run-slot" <<'X'
#!/bin/sh
echo "$*" >> "$FAKE/run-slot.log"
case "$1" in
  needs-open) _r="$(awk -F '\t' -v s="$2" '$1 == s { print $2 }' \
      "$FAKE/open" 2>/dev/null)"
    test -n "$_r" && echo "$_r" ;;
  gate) test "$2" != revive || ! test -f "$FAKE/full" ;;
esac
X
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

_given() {
  tmux kill-server 2>/dev/null
  rm -rf "$LOCAL_CONFIG" "$CLAUDE_CONFIG_DIR" "$_t/w" "$FAKE/notify" \
    "$FAKE/open" "$FAKE/full" "$FAKE/run-slot.log"
  mkdir -p "$LOCAL_CONFIG" "$CLAUDE_CONFIG_DIR/sessions" "$_t/w"
}

# _chat NAME [work|busy]: session NAME, window cli, in $_t/w/NAME,
# running claude with session id sNAME.
_chat() {
  mkdir -p "$_t/w/$1"
  test -z "${2:-}" || : > "$_t/w/$1/.$2"
  if tmux has-session 2>/dev/null; then
    tmux new-session -d -s "$1" -n cli -c "$_t/w/$1" \
      "FAKE_SID=s$1 exec $FAKE/bin/claude"
  else
    tmux -f /dev/null new-session -d -s "$1" -n cli -c "$_t/w/$1" \
      "FAKE_SID=s$1 exec $FAKE/bin/claude"
  fi
}

# Waits up to 5s for every chat's session file and pane output.
_settle() {
  _n=0
  while test "$_n" -lt 25; do
    _n=$((_n + 1))
    test "$(claude-pane map | wc -l)" -ge "$1" && break
    perl -e 'select undef, undef, undef, 0.2'
  done
  perl -e 'select undef, undef, undef, 0.3'
}

_run() { "$_rev" >/dev/null 2>&1; }
_q="$LOCAL_CONFIG/tmux-revive.queue"
_said() {
  grep -c '^said tmux restarted at [0-9:]* while you were working' \
    "$_t/w/$1/.got" 2>/dev/null
}

# --- crash: the server dies, a later run finds none
_given
_chat a work; _chat b; _settle 2
printf 'sb\tturn ended 2m ago\n' > "$FAKE/open"
_run
_check "snapshot marks the spinning chat working, the idle one not" \
  'grep -q "^a	cli	.*	sa	1$" "$LOCAL_CONFIG/tmux-revive.snapshot" \
    && grep -q "^b	cli	.*	sb	-$" "$LOCAL_CONFIG/tmux-revive.snapshot"'
rm -f "$_t/w/a/.work"
tmux kill-server; rm -f "$CLAUDE_CONFIG_DIR"/sessions/*
_run
_check "crash: both queued and started, the working one with a time" \
  'test "$(cut -f1,2,8 "$_q" | sort | tr "\t\n" ",;")" \
    = "started,a,$(date +%H:%M);started,b,-;"'
_run; _settle 2
_check "crash: the working chat through a revive gate, first" \
  'test "$(grep -E "^gate|^needs-open" "$FAKE/run-slot.log" | cut -d" " -f1-3 \
    | tr "\n" ";")" = "gate revive revive:a:cli:sa;needs-open sb b;$(
    )gate start revive:b:cli:sb;"'
_check "crash: both resumed by session id" \
  'grep -qx "argv --resume sa" "$_t/w/a/.got" \
    && grep -qx "argv --resume sb" "$_t/w/b/.got"'
_run; _settle 2
_check "crash: the working chat is told once, the idle one not" \
  'test "$(_said a)" = 1 && test "$(_said b)" = 0'
_check "crash: one ping sums it up" \
  'grep -qx "tmux revive revived 2 Claude chat(s), told 1 to carry on" \
    "$FAKE/notify" && test ! -e "$_q"'
_run
_check "crash: a later run tells nobody again" \
  'test "$(_said a)" = 1 && test "$(wc -l < "$FAKE/notify")" -eq 1'

# --- park: an idle chat with no reason to be up waits as closed, and
# only once no working chat waits for room
_given
_chat a work; _chat c; _settle 2
_run
rm -f "$_t/w/a/.work"
tmux kill-server; rm -f "$CLAUDE_CONFIG_DIR"/sessions/*
: > "$FAKE/full"
_run
_check "park: the idle chat waits while a working one has no room" \
  'test "$(cut -f1,2 "$_q" | sort | tr "\t\n" ",;")" = "todo,a;todo,c;" \
    && ! grep -q "needs-open" "$FAKE/run-slot.log"'
rm -f "$FAKE/full"
_run; _settle 1
_p="$(tmux display-message -p -t =c:cli '#{pane_id}' 2>/dev/null)"
_check "park: the idle one gets a shell where it was, recorded closed" \
  'grep -q "^park sc $_p c /.*/w/c$" "$FAKE/run-slot.log" \
    && test "$(tmux display-message -p -t "$_p" "#{pane_current_command}")" \
      != claude && test "$(cut -f1 "$_q" | grep -c parked)" = 1'
_run; _settle 1; _run
_check "park: the ping counts it" \
  'grep -q "revived 1 Claude chat(s), told 1 to carry on, 1 idle ones $(
    )closed (focus resumes)" "$FAKE/notify"'

# --- timer: an idle chat whose wakeup died with it is told too
_given
_chat d; _settle 1
_run
tmux kill-server; rm -f "$CLAUDE_CONFIG_DIR"/sessions/*
printf 'sd\twakeup at 10:00\n' > "$FAKE/open"
_run; _run; _settle 1; _run
_check "timer: resumed and told to carry on" \
  'grep -qx "argv --resume sd" "$_t/w/d/.got" && test "$(_said d)" = 1'

# --- restart: kill-server, a new server is up before the next run
_given
_chat a work; _chat b work; _settle 2
_run
rm -f "$_t/w/a/.work" "$_t/w/b/.work"
tmux kill-server; rm -f "$CLAUDE_CONFIG_DIR"/sessions/*
sleep 1
_chat b; _settle 1
_st="$(date -r "$(tmux display-message -p '#{start_time}')" +%H:%M)"
_run
_check "restart: a chat live again is not queued" \
  'test "$(cut -f2 "$_q")" = a'
_check "restart: the time told is the new server's start" \
  'test "$(cut -f8 "$_q")" = "$_st"'
_run; _settle 2; _run; _settle 1
_check "restart: told, and the ping counts one" \
  'test "$(_said a)" = 1 && grep -q "revived 1 Claude chat(s), told 1" \
    "$FAKE/notify"'

# --- untold: the resumed chat never shows an empty prompt
_given
_chat a busy; _settle 1
_run
tmux kill-server; rm -f "$CLAUDE_CONFIG_DIR"/sessions/*
_run; _run; _settle 1; _run
_check "untold: still pending within 10 minutes" \
  'test "$(cut -f1 "$_q")" = started && test ! -e "$FAKE/notify"'
gawk -F '\t' -v OFS='\t' '{ $7 -= 700 } 1' "$_q" > "$_q.n" \
  && mv "$_q.n" "$_q"
_run
_check "untold: given up after 10 minutes, nothing typed" \
  'test "$(_said a)" = 0 && grep -q "revived 1 Claude chat(s), told 0" \
    "$FAKE/notify" && grep -q "	untold	a	" \
    "$LOCAL_CONFIG/tmux-revive.log"'

echo "$_pass passed, $_fail failed"
test "$_fail" = 0
