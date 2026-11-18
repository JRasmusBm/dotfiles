#!/bin/sh
#
# tests/wt-tell-busy.sh [BIN] — scenarios for bin/wt-tell's delivery
# (RAS-79: a tell to a busy agent goes to its chat as a Claude Code
# message, claude-msg, queued till its next turn, instead of exit 1;
# an idle one waits its turn in run-slot first). A throwaway tmux
# server whose `cli` pane reads as Claude; claude-pane, claude-msg,
# run-slot and notif are logging fakes first on PATH; LOCAL_CONFIG and
# CLAUDE_CONFIG_DIR are a temp dir. Nothing real is touched. BIN
# defaults to this checkout's bin/.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_bin="${1:-$_root/bin}"
_t="$(mktemp -d /tmp/wtb.XXXX)"
unset TMUX TMUX_PANE WT_TELL_SID WT_TELL_NO_REVIVE RUN_SLOT_PENDING
export TMUX_TMPDIR="$_t/s" LOCAL_CONFIG="$_t/cfg" \
  CLAUDE_CONFIG_DIR="$_t/cc" FAKE="$_t/fake"
test -n "${KEEP:-}" || trap 'tmux kill-server 2>/dev/null; rm -rf "$_t"' EXIT
mkdir -p "$TMUX_TMPDIR" "$LOCAL_CONFIG/worktrees" \
  "$CLAUDE_CONFIG_DIR/sessions" "$FAKE"
export PATH="$FAKE:$_bin:$PATH"
_fail=0
ok() { echo "ok   $1"; }
no() { echo "FAIL $1"; _fail=1; }
check() { if eval "$2"; then ok "$1"; else no "$1"; fi; }

_sid=aaaaaaaa-0000-0000-0000-000000000000
cat > "$FAKE/claude-pane" <<EOF
#!/bin/sh
test "\$1" = of && echo $_sid
EOF
cat > "$FAKE/claude-msg" <<'EOF'
#!/bin/sh
printf '%s|%s\n' "$1" "$2" >> "$FAKE/msg"
exit "${FAKE_MSG_RC:-0}"
EOF
cat > "$FAKE/run-slot" <<'EOF'
#!/bin/sh
echo "$*" >> "$FAKE/slot"
test "$1" = gate && exit "${FAKE_GATE_RC:-0}"
exit 0
EOF
printf '#!/bin/sh\n' > "$FAKE/notif"
chmod +x "$FAKE/claude-pane" "$FAKE/claude-msg" "$FAKE/run-slot" \
  "$FAKE/notif"

# A pane whose command reads as `claude`: a tiny binary of that name
# running a sleeping script under sh (a copied binary won't start on
# macOS).
printf '%s\n' '#include <unistd.h>' '#include <sys/wait.h>' \
  'int main(int c, char **v) { int s; pid_t p = fork();' \
  '  if (!p) { execv("/bin/sh", v); return 127; }' \
  '  waitpid(p, &s, 0); return 0; }' > "$_t/c.c"
cc -o "$FAKE/claude" "$_t/c.c" || { echo "FAIL no cc"; exit 1; }
printf '#!/bin/sh\nexec sleep 600\n' > "$_t/claude.sh"

_w="$_t/repo/.worktrees/w"
mkdir -p "$_w"
tmux new-session -d -s w -n cli -x 120 -y 30 \
  "exec '$FAKE/claude' '$_t/claude.sh'"
sleep 0.5
check "the fake pane reads as claude" \
  'test "$(tmux display-message -p -t "=w:cli" "#{pane_current_command}")" = claude'

status() {
  printf '{"sessionId":"%s","status":"%s"}\n' "$_sid" "$1" \
    > "$CLAUDE_CONFIG_DIR/sessions/4242.json"
}
fresh() { rm -f "$LOCAL_CONFIG/wt-told" "$FAKE/msg" "$FAKE/slot"; }
# tell KEY [PROMPT]: runs wt-tell, sets _rc and _out.
tell() {
  _out="$(wt-tell "$_w" "$1" "ping $1" "${2:-hello $1}" 2>"$_t/err")"
  _rc=$?
}
told() { grep -qxF "$_w	$1" "$LOCAL_CONFIG/wt-told" 2>/dev/null; }
gated() { grep -q '^gate tell ' "$FAKE/slot" 2>/dev/null; }

echo "== 1. busy chat"
fresh; status busy; tell k1
check "exits 0" 'test "$_rc" = 0'
check "claude-msg got the sid and the prompt" \
  'test "$(cat "$FAKE/msg")" = "$_sid|hello k1"'
check "run-slot gate not called" '! gated'
check "told recorded" 'told k1'
check "stdout says told" \
  'case "$_out" in "told w"*) true ;; *) false ;; esac'

echo "== 2. idle chat, room"
fresh; status idle; FAKE_GATE_RC=0; export FAKE_GATE_RC; tell k2
check "exits 0" 'test "$_rc" = 0'
check "gated as a tell" 'grep -q "^gate tell tell:w:k2 -- " "$FAKE/slot"'
check "claude-msg called" 'test "$(cat "$FAKE/msg")" = "$_sid|hello k2"'
check "told recorded" 'told k2'

echo "== 3. idle chat, no room"
fresh; status idle; FAKE_GATE_RC=75; tell k3
check "exits 0" 'test "$_rc" = 0'
check "says queued" 'case "$_out" in queued*) true ;; *) false ;; esac'
check "claude-msg not called" 'test ! -s "$FAKE/msg"'
check "wt-told not written" 'test ! -s "$LOCAL_CONFIG/wt-told"'
FAKE_GATE_RC=0

echo "== 4. busy chat, socket refuses"
fresh; status busy; FAKE_MSG_RC=1; export FAKE_MSG_RC; tell k4
check "exits 1" 'test "$_rc" = 1'
check "nothing recorded" 'test ! -s "$LOCAL_CONFIG/wt-told"'
FAKE_MSG_RC=0

echo "== 5. once per key"
fresh; status busy; tell k5; tell k5
check "second call exits 0" 'test "$_rc" = 0'
check "only one message sent" 'test "$(grep -c . "$FAKE/msg")" = 1'
check "told once" 'test "$(grep -c "	k5$" "$LOCAL_CONFIG/wt-told")" = 1'

echo "== 6. open w8 rides along"
fresh; status busy
_until="$(date -v+2H +%FT%H:%M)"
printf 'w\tb/w\t%s\twaiting on CI\t100\n' "$_until" \
  > "$LOCAL_CONFIG/worktrees/repo.waiting"
tell k6
check "the prompt names the open w8" \
  'grep -q "^$_sid|hello k6 Your wt w8 is still open: waiting on CI, until $(echo "$_until" | tr T " ")\." "$FAKE/msg"'
check "and how to end it" 'grep -q "run wt w8 done" "$FAKE/msg"'
rm -f "$LOCAL_CONFIG/worktrees/repo.waiting"

exit "$_fail"
