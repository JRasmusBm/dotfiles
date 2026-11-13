#!/bin/sh
#
# tests/claude-notify-dedupe.sh [BIN] — RAS-21: the Claude Notification
# hook adds no row its pane already has pending (same class and text),
# and pings READY TO MERGE once per head sha unless the agent asks
# something. Nothing real is touched: LOCAL_CONFIG and the repo are a
# temp dir, and tmux, gh, the toast and the logs are fakes first on
# PATH. BIN defaults to this checkout's bin/.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_bin="${1:-$_root/bin}"
_t="$(mktemp -d /tmp/tcnd.XXXX)"
test -n "${KEEP:-}" || trap 'rm -rf "$_t"' EXIT
unset TMUX TMUX_PANE
export LOCAL_CONFIG="$_t/cfg" FAKE="$_t/fake"
mkdir -p "$LOCAL_CONFIG/worktrees" "$FAKE/bin"
for c in tmux osascript afplay focus-log lin wt-tell claude-pane \
  pr-merged-tell; do
  printf '#!/bin/sh\necho "%s $*" >> "$FAKE/calls"\nexit 1\n' "$c" \
    > "$FAKE/bin/$c"
done
# gh: the PR in $FAKE/pr, else none.
printf '#!/bin/sh\ncat "$FAKE/pr" 2>/dev/null || exit 1\n' > "$FAKE/bin/gh"
chmod +x "$FAKE/bin/"*
export PATH="$FAKE/bin:$_bin:$PATH"
export GIT_CONFIG_COUNT=1 GIT_CONFIG_KEY_0=core.hooksPath \
  GIT_CONFIG_VALUE_0=/dev/null
_inbox="$LOCAL_CONFIG/notifications"
git init -q "$_t/app"
git -C "$_t/app" commit -q --allow-empty -m init
cd "$_t/app" || exit 1
export TMUX_PANE=%7

_fail=0
ok() { echo "ok   $1"; }
no() { echo "FAIL $1"; _fail=1; }
check() { if eval "$2"; then ok "$1"; else no "$1"; fi; }

# say TEXT: the agent's last message, then one stop.
say() {
  jq -nc --arg t "$1" '{type: "assistant",
    message: {content: [{type: "text", text: $t}]}}' > "$_t/tr.jsonl"
  jq -nc --arg p "$_t/tr.jsonl" '{notification_type: "idle_prompt",
    transcript_path: $p, session_id: "s1"}' | claude-notify
}
pr() {
  jq -nc --arg sha "$1" '{number: 5, state: "OPEN", isDraft: false,
    mergeStateStatus: "CLEAN", statusCheckRollup: [], body: "",
    baseRefName: "dev", headRefOid: $sha}' > "$FAKE/pr"
}
rows() { awk -F'\t' -v c="$1" '$8 == c' "$_inbox" 2>/dev/null | wc -l \
  | tr -d ' '; }

echo '# same ping pending'
say 'Done.'
check 'a stop pings fyi done' 'test "$(rows fyi)" = 1'
say 'Done.'
check 'the same stop again adds no row' 'test "$(rows fyi)" = 1'
say 'Shall I also do X?'
check 'a question pings' 'test "$(rows blocked)" = 1'
say 'Shall I also do X?'
check 'the same question again adds no row' 'test "$(rows blocked)" = 1'
say 'Or Y instead?'
check 'a new question pings' 'test "$(rows blocked)" = 2'

echo '# merge once per head sha'
: > "$_inbox"
pr aaa
say 'Done.'
check 'a green PR pings merge' 'test "$(rows merge)" = 1'
: > "$_inbox"
say 'Done.'
check 'the same sha, row cleared: no second ping' 'test "$(rows merge)" = 0'
say 'Merge it, or wait for Z?'
check 'the same sha with a question pings' \
  'test "$(cut -f4 "$_inbox")" = "READY TO MERGE #5 (asks: Merge it, or wait for Z?)"'
: > "$_inbox"
pr bbb
say 'Done.'
check 'a new sha pings again' 'test "$(rows merge)" = 1'
check 'keyed per repo, PR and sha in wt-told' \
  'grep -c "merge-ping:5:" "$LOCAL_CONFIG/wt-told" | grep -qx 2'
: > "$_inbox"
pr ccc
printf '%s\tmerge-ping:5:ccc\n' "$(pwd -P)" >> "$LOCAL_CONFIG/wt-told"
say 'Done.'
check 'a sha wt-pr-watch already pinged: no second ping' \
  'test "$(rows merge)" = 0'
test "$_fail" = 0 || { cat "$_inbox"; cat "$FAKE/calls"; }
exit "$_fail"
