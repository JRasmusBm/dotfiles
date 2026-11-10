#!/bin/sh
#
# tests/notify-row.sh [BIN] — RAS-47: a multi-line `notify` writes one
# inbox row, and the readers (`notif`, `notif-depth`, `wt-cold --ping`)
# skip a line too short to be a row instead of crashing. Nothing real
# is touched: LOCAL_CONFIG and the one board repo are a temp dir, and
# tmux, the toast and Linear are fakes first on PATH. BIN defaults to
# this checkout's bin/.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_bin="${1:-$_root/bin}"
_t="$(mktemp -d /tmp/tnr.XXXX)"
test -n "${KEEP:-}" || trap 'rm -rf "$_t"' EXIT
unset TMUX TMUX_PANE
export LOCAL_CONFIG="$_t/cfg" FAKE="$_t/fake"
mkdir -p "$LOCAL_CONFIG/worktrees" "$FAKE/bin"
for c in tmux osascript afplay focus-log lin wt-tell claude-pane; do
  printf '#!/bin/sh\necho "%s $*" >> "$FAKE/calls"\nexit 1\n' "$c" \
    > "$FAKE/bin/$c"
done
# gh: no PRs.
printf '#!/bin/sh\necho "[]"\n' > "$FAKE/bin/gh"
chmod +x "$FAKE/bin/"*
export PATH="$FAKE/bin:$_bin:$PATH"
export GIT_CONFIG_COUNT=1 GIT_CONFIG_KEY_0=core.hooksPath \
  GIT_CONFIG_VALUE_0=/dev/null
_inbox="$LOCAL_CONFIG/notifications"

_fail=0
ok() { echo "ok   $1"; }
no() { echo "FAIL $1"; _fail=1; }
check() { if eval "$2"; then ok "$1"; else no "$1"; fi; }

echo '# notify'
(cd "$_t" && NOTIFY_CLASS=fyi notify "P0	brief" "$(printf \
  'line one\n\n12\nline	three\n')")
check 'a multi-line message is one row' \
  'test "$(wc -l < "$_inbox")" -eq 1'
check 'with all nine fields' \
  'test "$(awk -F"\t" "{ print NF }" "$_inbox")" -eq 9'
check 'title tab became a space' 'test "$(cut -f3 "$_inbox")" = "P0 brief"'
check 'lines joined by a separator, blank ones dropped' \
  'test "$(cut -f4 "$_inbox")" = "line one · 12 · line three"'
NOTIFY_CLASS=fyi notify t 'plain' >/dev/null
check 'a one-line message is unchanged' \
  'test "$(sed -n 2p "$_inbox" | cut -f4)" = plain'

echo '# readers, on an inbox with the old split row'
: > "$_inbox"
printf '%s\tctx\tt\tline one\n12\n\nline three\t/p\t\t\tfyi\t\n' \
  "$(date +%s)" >> "$_inbox"
printf '%s\tother\tt\tm\t/q\t%%9\tsticky\tblocked\t\n' \
  "$(date +%s)" >> "$_inbox"
check 'notif count sees the one real row' \
  'test "$(notif count)" = "(1)  "'
check 'notif-depth runs' 'notif-depth --days 1 >/dev/null 2>"$_t/err"'
check 'notif-depth inbox() skips the short rows' \
  'test "$(python3 -c "
import importlib.machinery as m, importlib.util as u, sys
l = m.SourceFileLoader(\"d\", sys.argv[1]); s = u.spec_from_loader(\"d\", l)
d = u.module_from_spec(s); l.exec_module(d); print(len(d.inbox()))
" "$_bin/notif-depth")" = 1'

git init -q "$_t/app"
git -C "$_t/app" commit -q --allow-empty -m init
printf '# IN PROGRESS\n' > "$LOCAL_CONFIG/worktrees/app"
check 'wt-cold --ping survives' \
  'WT_SYNC_REPOS="$_t/app" wt-cold --ping >/dev/null 2>"$_t/err"'
check 'and writes its counts line' \
  'test "$(awk -F"\t" "{ print \$NF }" "$LOCAL_CONFIG/stalled.log")" = 1'
test "$_fail" = 0 || cat "$_t/err"
exit "$_fail"
