#!/bin/sh
#
# tests/claude-archive.sh [BIN] — scenarios for bin/claude-archive (a
# month-old session loses its logged API requests and image bytes and
# is gzipped; recent, live and open ones stay), claude-unarchive and
# the claude shim's restore on `--resume SID`, and the readers that
# open .jsonl.gz (claude-log, chats). Fake transcripts in a temp
# CLAUDE_CONFIG_DIR. BIN defaults to this checkout's bin/.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_bin="${1:-$_root/bin}"
_t="$(cd "$(mktemp -d /tmp/cat.XXXX)" && pwd -P)"
_pids=""
trap 'kill $_pids 2>/dev/null; test -n "${KEEP:-}" || rm -rf "$_t"' EXIT
export CLAUDE_CONFIG_DIR="$_t/cc" HOME="$_t/home" \
  XDG_CACHE_HOME="$_t/cache"
mkdir -p "$CLAUDE_CONFIG_DIR/sessions" "$HOME" "$_t/fake"
ln -s "$CLAUDE_CONFIG_DIR" "$HOME/.claude"
printf '#!/bin/sh\necho "real claude $*"\n' > "$_t/fake/claude"
chmod +x "$_t/fake/claude"
export PATH="$_bin:$PATH"
_fail=0
check() { if eval "$2"; then echo "ok   $1"; else echo "FAIL $1"
  _fail=1; fi; }

_p="$CLAUDE_CONFIG_DIR/projects/-r-app"
_old=202601010000
_img='iVBORw0KGgo'"$(printf 'A%.0s' $(seq 1 2000))"
# Session $1, subagent too; the main file's mtime is $2.
chat() {
  mkdir -p "$_p/$1/subagents" "$_p/$1/tool-results"
  cat > "$_p/$1.jsonl" <<EOF
{"type":"user","uuid":"u1","parentUuid":null,"sessionId":"$1","timestamp":"2026-01-01T00:00:00.000Z","message":{"role":"user","content":"hello archive"}}
{"type":"api-request","id":"r1","sessionId":"$1","params":{"big":"$_img"}}
{"type":"api-request-blob","hash":"h1","sessionId":"$1","message":{"x":"$_img"}}
{"type":"api-request-shape","shapeHash":"s1","sessionId":"$1"}
{"type":"assistant","uuid":"a1","parentUuid":"u1","requestRef":"r1","message":{"content":[{"type":"text","text":"hi back"}]}}
{"type":"user","uuid":"u2","parentUuid":"a1","message":{"role":"user","content":[{"type":"tool_result","content":[{"type":"image","source":{"type":"base64","media_type":"image/jpeg","data":"$_img"}}]}]},"toolUseResult":[{"type":"image","source":{"type":"base64","media_type":"image/jpeg","data":"$_img"}}]}
EOF
  printf '%s\n' '{"type":"user","uuid":"s1","message":{"content":"sub"}}' \
    > "$_p/$1/subagents/agent-x.jsonl"
  echo out > "$_p/$1/tool-results/t.txt"
  touch -t "$_old" "$_p/$1/subagents/agent-x.jsonl" \
    "$_p/$1/tool-results/t.txt" "$_p/$1/subagents" "$_p/$1/tool-results"
  touch -t "$2" "$_p/$1.jsonl" "$_p/$1"
}
chat aaaa1111 "$_old"
chat bbbb2222 "$_old"
touch "$_p/bbbb2222/subagents/agent-x.jsonl"
chat cccc3333 "$_old"
sleep 300 & _pids="$_pids $!"
printf '{"sessionId":"cccc3333"}' > "$CLAUDE_CONFIG_DIR/sessions/$!.json"
chat dddd4444 "$_old"
( exec 3<"$_p/dddd4444.jsonl"; exec sleep 300 ) & _pids="$_pids $!"
touch -t "$_old" "$_p"
sleep 1
_sum0="$(cksum < "$_p/aaaa1111.jsonl")"

_out="$(claude-archive --dry-run)"
check "dry run: counts one session" \
  'echo "$_out" | grep -q "would archive 1 sessions"'
check "dry run: skips the recent, live and open ones" \
  'echo "$_out" | grep -q "recent=1 live=1 open=1"'
check "dry run: touches nothing" \
  'test "$(cksum < "$_p/aaaa1111.jsonl")" = "$_sum0" &&
   ! ls "$_p"/*.gz 2>/dev/null'

claude-archive --backup "$_t/bak" > "$_t/run1"
_a="$_p/aaaa1111"
check "old session gzipped, plain .jsonl gone" \
  'test -f "$_a.jsonl.gz" && ! test -e "$_a.jsonl" &&
   test -f "$_a/subagents/agent-x.jsonl.gz" &&
   ! test -e "$_a/subagents/agent-x.jsonl"'
check "tool-results left alone" 'test -f "$_a/tool-results/t.txt"'
check "api-request rows dropped" \
  '! gzip -cd "$_a.jsonl.gz" | grep -q "api-request"'
check "chain rows kept byte for byte" \
  'test "$(gzip -cd "$_a.jsonl.gz" | grep -c "\"uuid\"")" = 3 &&
   gzip -cd "$_a.jsonl.gz" | grep -qF "$(sed -n 5p "$_t/bak/-r-app/aaaa1111.jsonl")"'
check "images swapped for a valid png, shape kept" \
  'gzip -cd "$_a.jsonl.gz" | sed -n 3p | jq -e "
     [.. | objects | select(.type == \"image\") | .source]
     | length == 2 and all(.type == \"base64\"
       and .media_type == \"image/png\" and (.data | length) < 100)" \
     >/dev/null'
check "every line still JSON" \
  'gzip -cd "$_a.jsonl.gz" | jq -e . >/dev/null'
check "mtimes kept: file, session dir, project dir" \
  'test "$(stat -f %Sm -t %Y%m%d%H%M "$_a.jsonl.gz")" = "$_old" &&
   test "$(stat -f %Sm -t %Y%m%d%H%M "$_a/subagents")" = "$_old" &&
   test "$(stat -f %Sm -t %Y%m%d%H%M "$_p")" = "$_old"'
check "backup holds the original" \
  'test "$(cksum < "$_t/bak/-r-app/aaaa1111.jsonl")" = "$_sum0"'
check "recent, live and open sessions untouched" \
  'test -f "$_p/bbbb2222.jsonl" && test -f "$_p/cccc3333.jsonl" &&
   test -f "$_p/dddd4444.jsonl"'
check "second run is a no-op" \
  'claude-archive | grep -q "archived 0 sessions"'

check "claude-log reads an archived session" \
  'claude-log -p aaaa | grep -q "hello archive"'
check "chats indexes an archived session" \
  'CHATS_DAYS=1000 chats _index | grep -q "hello archive"'

check "claude-unarchive restores by prefix" \
  'claude-unarchive aaaa >/dev/null && test -f "$_a.jsonl" &&
   ! test -e "$_a.jsonl.gz" && test -f "$_a/subagents/agent-x.jsonl" &&
   test "$(stat -f %Sm -t %Y%m%d%H%M "$_a.jsonl")" = "$_old" &&
   test "$(stat -f %Sm -t %Y%m%d%H%M "$_p")" = "$_old" &&
   ! grep -q api-request "$_a.jsonl"'
check "unknown session fails" '! claude-unarchive zzzz 2>/dev/null'

claude-archive --only aaaa >/dev/null
check "the shim restores on --resume SID" \
  'CLAUDE_EXTRA_SETTINGS= CLAUDE_REAL="$_t/fake/claude" \
     "$_root/shims/claude" --resume aaaa1111 \
     | grep -q "real claude --resume aaaa1111" && test -f "$_a.jsonl"'

exit $_fail
