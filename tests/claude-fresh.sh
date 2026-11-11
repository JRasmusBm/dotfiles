#!/bin/sh
#
# tests/claude-fresh.sh [BIN] — scenarios for bin/claude-fresh (RAS-53:
# a big chat goes on fresh, from a brief, instead of being resumed
# whole) and the claude-pane lookups that follow its successors. Fake
# transcripts in a temp CLAUDE_CONFIG_DIR; `hand` runs against a
# throwaway tmux server whose pane fakes Claude's idle prompt. Nothing
# real is touched. BIN defaults to this checkout's bin/.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_bin="${1:-$_root/bin}"
_t="$(mktemp -d /tmp/cft.XXXX)"
unset TMUX TMUX_PANE
export TMUX_TMPDIR="$_t/s" LOCAL_CONFIG="$_t/cfg" \
  CLAUDE_CONFIG_DIR="$_t/cc" CLAUDE_FRESH_POLL=0.2
test -n "${KEEP:-}" || trap 'tmux kill-server 2>/dev/null; rm -rf "$_t"' EXIT
mkdir -p "$TMUX_TMPDIR" "$LOCAL_CONFIG" "$CLAUDE_CONFIG_DIR/sessions" \
  "$_t/fake"
export PATH="$_t/fake:$_root/shims:$_bin:$PATH"
_fail=0
ok() { echo "ok   $1"; }
no() { echo "FAIL $1"; _fail=1; }
check() { if eval "$2"; then ok "$1"; else no "$1"; fi; }

# A transcript for sid $1 in dir $2 whose last turn had $3 tokens.
chat() {
  _d="$CLAUDE_CONFIG_DIR/projects/$(printf '%s' "$2" | sed 's|[^A-Za-z0-9]|-|g')"
  mkdir -p "$_d"
  cat > "$_d/$1.jsonl" <<EOF
{"type":"user","cwd":"$2","message":{"role":"user","content":"please fix the thing"}}
{"type":"assistant","cwd":"$2","message":{"content":[{"type":"text","text":"Fixed it. Is the design right?"}],"usage":{"input_tokens":10,"cache_read_input_tokens":$3,"cache_creation_input_tokens":0}}}
{"type":"user","cwd":"$2","message":{"role":"user","content":[{"type":"tool_result","content":"x"}]}}
EOF
}

_w="$_t/repo/.worktrees/small"
mkdir -p "$_w" "$_t/repo/.worktrees/big"
_w="$(cd "$_w" && pwd -P)" _big="$(cd "$_t/repo/.worktrees/big" && pwd -P)"
chat 11111111-0000-0000-0000-000000000000 "$_w" 90000
chat 22222222-0000-0000-0000-000000000000 "$_big" 160000

echo "== resume"
_a="$(claude-fresh resume 11111111-0000-0000-0000-000000000000)"
check "a small chat resumes whole" \
  'test "$_a" = "--resume 11111111-0000-0000-0000-000000000000"'
_a="$(claude-fresh resume - "$_w")"
check "- finds the directory's latest chat" \
  'test "$_a" = "--resume 11111111-0000-0000-0000-000000000000"'
_a="$(claude-fresh resume - "$_t")"
check "- with no chat there continues as before" 'test "$_a" = --continue'
_a="$(claude-fresh resume 22222222-0000-0000-0000-000000000000)"
_new="$(printf '%s' "$_a" | awk '{ print $2 }')"
check "a big chat starts fresh with its own session id" \
  'case "$_a" in "--session-id $_new '"'"'Read "*) true ;; *) false ;; esac'
check "the fresh chat is the big one's successor" \
  'test "$(claude-fresh next 22222222-0000-0000-0000-000000000000)" = "$_new"'
_f="$LOCAL_CONFIG/briefs/$_new.md"
check "its brief names the old chat, quotes its last prompt and message" \
  'grep -q "claude-log -p 22222222" "$_f" && grep -q "> please fix the thing" "$_f" \
     && grep -q "> Fixed it. Is the design right?" "$_f"'
check "the brief skips tool results as prompts" '! grep -q "> x$" "$_f"'
check "its context shows in the brief" 'grep -q "160k" "$_f"'
check "ctx reads the last turn" \
  'test "$(claude-fresh ctx 11111111-0000-0000-0000-000000000000)" = 90010'
_a="$(CLAUDE_FRESH_CTX=50000 claude-fresh resume 11111111-0000-0000-0000-000000000000)"
check "CLAUDE_FRESH_CTX moves the limit" \
  'case "$_a" in --session-id*) true ;; *) false ;; esac'
_n1="$(claude-fresh next 11111111-0000-0000-0000-000000000000)"
printf '%s\t%s\t%s\n' 0 "$_n1" 33333333 >> "$LOCAL_CONFIG/claude-successors"
check "next follows a chain of successors" \
  'test "$(claude-fresh next 11111111-0000-0000-0000-000000000000)" = 33333333'

echo "== claude-pane follows successors"
check "a replaced chat with no pane has no cwd" \
  'test -z "$(claude-pane cwd 22222222-0000-0000-0000-000000000000)"'

echo "== hand"
# A pane whose command reads as `claude` (a tiny binary of that name
# running a script under sh: a copied shell won't start on macOS):
# shows an idle prompt, logs what is typed to $GOT, and after `/clear`
# writes a new session id.
printf '%s\n' '#include <unistd.h>' '#include <sys/wait.h>' \
  'int main(int c, char **v) { int s; pid_t p = fork();' \
  '  if (!p) { execv("/bin/sh", v); return 127; }' \
  '  waitpid(p, &s, 0); return 0; }' > "$_t/fake/c.c"
cc -o "$_t/fake/claude" "$_t/fake/c.c" || { echo "FAIL no cc"; exit 1; }
cat > "$_t/fake/claude.sh" <<'EOF'
#!/bin/sh
_sid="$1" _f="$CLAUDE_CONFIG_DIR/sessions/$$.json"
_pane="$TMUX_PANE"
w() { printf '{"sessionId":"%s","cwd":"%s","tmux":"t:@1.%s"}\n' \
  "$1" "$PWD" "$_pane" > "$_f"; }
w "$_sid"
p() { printf '\033[2J\033[H❯ \n-- INSERT --\n'; }
p
stty -echo 2>/dev/null
while IFS= read -r l; do
  echo "$l" >> "$GOT"
  case "$l" in /clear) _sid="cleared-$_sid"; w "$_sid" ;; esac
  printf '\033[2J\033[Hworking\n'
  case "$l" in busy) sleep 5 ;; *) sleep 0.3 ;; esac
  p
done
EOF
export GOT="$_t/got"
tmux new-session -d -s t -x 120 -y 30 "PATH='$PATH' GOT='$GOT' \
  CLAUDE_CONFIG_DIR='$CLAUDE_CONFIG_DIR' exec claude '$_t/fake/claude.sh' old-sid"
_p="$(tmux display-message -p -t t '#{pane_id}')"
sleep 1
check "the fake pane reads as an idle Claude" 'claude-pane-idle "$_p"'
check "claude-pane of finds its chat" 'test "$(claude-pane of "$_p")" = old-sid'
_out="$(printf 'Phase 2 of ABC-1: run the rd skill.\n' \
  | claude-fresh hand "$_p")"
check "hand returns at once, naming the brief" \
  'case "$_out" in "handing off after this turn: "*old-sid.md) true ;; *) false ;; esac'
_i=0
while test "$_i" -lt 50 && test "$(cat "$GOT" 2>/dev/null | grep -c .)" -lt 2; do
  sleep 0.2; _i=$((_i + 1))
done
check "it types /clear, then the read-your-brief prompt" \
  'test "$(sed -n 1p "$GOT")" = /clear \
     && sed -n 2p "$GOT" | grep -q "^Read .*/briefs/old-sid.md: it is your brief"'
check "the brief holds what was piped in" \
  'grep -q "run the rd skill" "$LOCAL_CONFIG/briefs/old-sid.md"'
check "the cleared chat is the old one's successor" \
  'test "$(claude-fresh next old-sid)" = cleared-old-sid'
check "claude-pane finds the old id in the same pane" \
  'test "$(claude-pane old-sid)" = "$_p"'

echo "== hand waits for the turn to end"
: > "$GOT"
tmux send-keys -t "$_p" busy Enter
sleep 0.5
printf 'later\n' | claude-fresh hand "$_p" >/dev/null
sleep 1
check "nothing is typed while its turn runs" '! grep -q /clear "$GOT"'
_i=0
while test "$_i" -lt 75 && ! grep -q /clear "$GOT"; do
  sleep 0.2; _i=$((_i + 1))
done
check "then it hands off" 'grep -q /clear "$GOT"'

test "$_fail" = 0 && echo "all passed" || { echo "FAILED"; exit 1; }
