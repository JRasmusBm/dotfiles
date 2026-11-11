#!/bin/sh
#
# tests/prio.sh [PRIO] — the priorities file and its CLI (bin/prio):
# parse and list (sources, groupings, notes, tickets from the cache),
# capture (`add`, `--top` below hand-pinned rows, a hand-removed
# outcome never comes back), `in`, hand edits (removed, pinned), the
# history log, done, tickets/slugs/rank and the brief. LOCAL_CONFIG is
# a temp dir; tmux is a fake with no panes; Linear is
# tests/prio-linear-fake. PRIO defaults to this checkout's bin/prio.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_prio="${1:-$_root/bin/prio}"
_t="$(mktemp -d /tmp/tpr.XXXX)"; test -z "${KEEP:-}" || echo "$_t"
test -n "${KEEP:-}" || trap 'rm -rf "$_t"' EXIT
export LOCAL_CONFIG="$_t/cfg"
mkdir -p "$LOCAL_CONFIG/worktrees" "$_t/bin"
unset TMUX TMUX_PANE
printf '#!/bin/sh\nexit 0\n' > "$_t/bin/tmux"
for c in notify notif; do printf '#!/bin/sh\n' > "$_t/bin/$c"; done
# The fake editor saves $_t/next over the file it is given.
printf '#!/bin/sh\ncp "%s/next" "$1"\n' "$_t" > "$_t/bin/ed"
# No linking or guessing agent here: tests/prio-sync.sh covers them.
printf '#!/bin/sh\necho {}\n' > "$_t/bin/claude"
chmod +x "$_t/bin/"*
export PATH="$_t/bin:$PATH" EDITOR="$_t/bin/ed" PRIO_CLAUDE="$_t/bin/claude" \
  PRIO_LINEAR_CMD="$_root/tests/prio-linear-fake" PRIO_FAKE="$_t/linear.json"
_f="$LOCAL_CONFIG/priorities"

_fail=0
ok() { echo "ok   $1"; }
no() { echo "FAIL $1"; _fail=1; }
check() { if eval "$2"; then ok "$1"; else no "$1"; fi; }
p() { "$_prio" "$@"; }

check "no file: ls says so" \
  'p ls | grep -q "No priorities"'
check "no file: brief asks for one" \
  'test "$(p brief)" = "No priority is set: what'"'"'s today'"'"'s P0?"'

cat > "$_t/linear.json" <<'X'
{"project:0a1b2c3d4e5f": ["ABC-1 completed me spike", "ABC-2 started me build it",
   "ABC-3 unstarted me docs", "ABC-30 started - theirs"],
 "parent:ABC-6": [{"id": "ABC-7 started me the fix",
   "kids": ["ABC-8 unstarted me its test"]}]}
X
cat > "$_f" <<'X'
# a comment
Ship the export
  > Lead 2026-11-09 - "export first"
  in https://linear.app/x/project/export-0a1b2c3d4e5f/overview   # export
  - talk to sales first

Fix the login
  in ABC-6
  in nonsense
X
p sync
check "ls: ranks, source, grouping, note, tickets with done first" \
  'p ls > "$_t/ls"; grep -q "^1\. Ship the export" "$_t/ls" \
   && grep -q "^2\. Fix the login" "$_t/ls" \
   && grep -q "   > Lead 2026-11-09" "$_t/ls" \
   && grep -q "   in https://linear.app/x/project/export-0a1b2c3d4e5f/overview   # export" "$_t/ls" \
   && grep -q "   - talk to sales first" "$_t/ls" \
   && grep -q "   in nonsense   (not a grouping)" "$_t/ls" \
   && test "$(grep -n "ABC-1 spike\|ABC-2 build" "$_t/ls" | cut -d: -f1 | tr "\n" ,)" \
     = "$(grep -n "ABC-1 spike" "$_t/ls" | cut -d: -f1),$(grep -n "ABC-2 build" "$_t/ls" | cut -d: -f1)," \
   && grep -q "\[x\] ABC-1 spike$" "$_t/ls" \
   && grep -q "\[ \] ABC-2 build it   \[no worktree\]" "$_t/ls" \
   && ! grep -q ABC-30 "$_t/ls"'
check "tickets: open ones, sub-issues two levels deep" \
  'test "$(p tickets | cut -f1,2 | tr "\t\n" ":,")" \
     = "1:ABC-2,1:ABC-3,2:ABC-7,2:ABC-8,"'
check "rank: branch, slug and worktree path" \
  'test "$(p rank feat/jrb/abc-2-build)" = 1 \
   && test "$(p rank abc-8-test)" = 2 \
   && test "$(p rank /r/.worktrees/abc-3-docs/sub)" = 1'
check "rank: none for a done ticket or a lookalike" \
  '! p rank abc-1-spike && ! p rank abc-27-other && ! p rank xabc-2'

# Capture: a new outcome goes last; --top goes above the first unpinned.
p add --by Lead --date 2026-11-10 --quote 'say "now"' "Cut costs" \
  "- [ ] ABC-9 audit" >/dev/null
check "add: new outcome appended last with source and note" \
  'p ls | grep -q "^3\. Cut costs" \
   && grep -q "  > Lead 2026-11-10 - \"say '"'"'now'"'"'\"" "$_f" \
   && grep -q "^  - ABC-9 audit$" "$_f"'
check "ls: an unlinked outcome says an agent links it" \
  'p ls | grep -A3 "^3\. Cut costs" | grep -q "no grouping: an agent links"'
check "add: existing outcome gets only new notes, source after sources" \
  'p add --by Boss --date 2026-11-11 --quote q "ship the export" \
     "talk to sales first" "check the numbers" | grep -q "source, 1 note" \
   && test "$(grep -c "talk to sales" "$_f")" = 1 \
   && test "$(sed -n 4p "$_f")" = "  > Boss 2026-11-11 - \"q\"" \
   && grep -q "^  - check the numbers" "$_f"'
check "add: nothing new says so" \
  'p add "Ship the export" "check the numbers" | grep -q "nothing new"'
p add --top "Urgent thing" >/dev/null
check "add --top: rank 1 with nothing pinned" \
  'test "$(p ls | grep "^1\.")" = "1. Urgent thing"'
check "log: a capture snapshot per priority, with its open tickets" \
  'test "$(awk -F "\t" "\$2 == \"capture\"" "$_f.log" | tail -4 \
     | cut -f3,4,5 | tr "\t\n" ":,")" \
     = "1:Urgent thing:,2:Ship the export:ABC-2 ABC-3,3:Fix the login:ABC-7 ABC-8,4:Cut costs:,"'

check "in: adds a grouping below the sources" \
  'p in "urgent thing" label:urgent >/dev/null \
   && test "$(sed -n "/^Urgent thing/{n;p;}" "$_f")" = "  in label:urgent"'
check "in: refuses what is no grouping" \
  '! p in "Urgent thing" whatever 2>/dev/null'

# Hand edit: move "Fix the login" to the top, drop "Cut costs".
cat > "$_t/next" <<'X'
Fix the login
  in ABC-6
Urgent thing
  in label:urgent
Ship the export
  in https://linear.app/x/project/export-0a1b2c3d4e5f
X
p edit
check "edit: moved-up outcome pinned, others not" \
  'test "$(cat "$_f.pinned")" = "Fix the login"'
check "edit: dropped outcome logged as removed" \
  'awk -F "\t" "\$2 == \"Cut costs\"" "$_f.removed" | grep -q .'
check "log: hand snapshot of the new order" \
  'test "$(awk -F "\t" "\$2 == \"hand\"" "$_f.log" | cut -f3,4,5 \
     | tr "\t\n" ":,")" \
     = "1:Fix the login:ABC-7 ABC-8,2:Urgent thing:,3:Ship the export:ABC-2 ABC-3,"'

_rc=0; p add "cut costs" "x" 2>"$_t/err" || _rc=$?
check "add: hand-removed outcome refused, exit 3" \
  'test "$_rc" = 3 && grep -q "removed by hand" "$_t/err" \
   && ! grep -qi "cut costs" "$_f"'
p add --top "Another" >/dev/null
check "add --top: lands below the pinned outcome" \
  'test "$(p ls | grep "^[12]\." | tr "\n" ",")" \
     = "1. Fix the login,2. Another,"'

# Board rows on a priority, and the brief.
printf '# IN PROGRESS\nfeat/jrb/abc-2-build\nfeat/jrb/abc-7-fix\nother\n' \
  > "$LOCAL_CONFIG/worktrees/repo"
check "slugs: board rows on a priority, rank order" \
  'test "$(p slugs | tr "\t\n" ":,")" \
     = "1:abc-7-fix:feat/jrb/abc-7-fix,4:abc-2-build:feat/jrb/abc-2-build,"'
printf '1\tabc-7-fix\tt\tm\t/r/.worktrees/abc-7-fix\t%%1\tsticky\tenv\t\t\n' \
  > "$LOCAL_CONFIG/notifications"
check "brief: needs you, worktree state, tickets with no worktree" \
  'p brief > "$_t/brief"; grep -q "^Today'"'"'s priorities:" "$_t/brief" \
   && grep -q "^1\. Fix the login" "$_t/brief" \
   && grep -q "   needs you: abc-7-fix" "$_t/brief" \
   && grep -q "   abc-7-fix: no agent" "$_t/brief" \
   && grep -q "   no worktree: ABC-8" "$_t/brief" \
   && grep -A1 "^2\. Another" "$_t/brief" | grep -q "no grouping yet" \
   && grep -A1 "^3\. Urgent" "$_t/brief" | grep -q "no open ticket"'
check "ls: needs you, and each ticket board section and agent state" \
  'p ls | grep -q "^1\. Fix the login   \[needs you: abc-7-fix\]" \
   && p ls | grep -q "ABC-7 the fix   \[in progress: no agent\]"'

# Swapping two outcomes pins the one moved up, not the one moved down.
awk '/^[^ #]/ { n++ } n == 2 { print }' "$_f" > "$_t/next"
awk '/^[^ #]/ { n++ } n != 2 { print }' "$_f" >> "$_t/next"
p edit
check "edit: swap of two pins the one moved up" \
  'test "$(tr "\n" "," < "$_f.pinned")" = "Fix the login,Another,"'

# A vim-like editor opens each priority as one closed fold, its lines
# included: real nvim records where each line's fold starts.
if command -v nvim >/dev/null; then
  printf '#!/bin/sh\nexec %s --headless -u NONE -i NONE "$@" -c %s -c "qa!"\n' \
    "$(command -v nvim)" \
    "'call writefile(map(range(1, line(\"\$\")), \"foldclosed(v:val)\"), \"$_t/folds\")'" \
    > "$_t/bin/nvim"
  chmod +x "$_t/bin/nvim"
  EDITOR=nvim p edit </dev/null >/dev/null 2>&1
  check "edit: nvim folds each priority with its lines" \
    'test "$(grep -n "^[^ #]" "$_f" | cut -d: -f1 | tr "\n" ,)" \
       = "$(sort -un "$_t/folds" | grep -v "^-1" | tr "\n" ,)" \
     && test "$(grep -c "^-1" "$_t/folds")" = "$(grep -c "^#\|^$" "$_f")"'
fi

p done "Another" >/dev/null
check "done: gone, not a removal" \
  '! grep -q "^Another" "$_f" && ! grep -q "Another" "$_f.removed"'
for o in "Fix the login" "Urgent thing" "Ship the export"; do
  p done "$o" >/dev/null
done
check "log: zero priorities is a rank-0 row" \
  'tail -1 "$_f.log" | awk -F "\t" "\$3 == 0 && \$4 == \"\" && NF == 5" \
   | grep -q .'
check "pinned: emptied with its outcome" 'test ! -s "$_f.pinned"'

exit "$_fail"
