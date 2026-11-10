#!/bin/sh
#
# tests/prio.sh [PRIO] — the priorities file and its CLI (bin/prio):
# parse and list, capture (`add`, `--top` below hand-pinned rows, a
# hand-removed outcome or step never comes back), hand edits (removed,
# pinned), the history log, done, tickets/slugs/rank and the brief.
# LOCAL_CONFIG is a temp dir; tmux is a fake with no panes. PRIO
# defaults to this checkout's bin/prio.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_prio="${1:-$_root/bin/prio}"
_t="$(mktemp -d /tmp/tpr.XXXX)"
trap 'rm -rf "$_t"' EXIT
export LOCAL_CONFIG="$_t/cfg"
mkdir -p "$LOCAL_CONFIG/worktrees" "$_t/bin"
unset TMUX TMUX_PANE
printf '#!/bin/sh\nexit 0\n' > "$_t/bin/tmux"
# The fake editor saves $_t/next over the file it is given.
printf '#!/bin/sh\ncp "%s/next" "$1"\n' "$_t" > "$_t/bin/ed"
chmod +x "$_t/bin/"*
export PATH="$_t/bin:$PATH" EDITOR="$_t/bin/ed"
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

cat > "$_f" <<'X'
# a comment
Ship the export
  > Lead 2026-11-09 - "export first"
  - [x] ABC-1 spike
  - [ ] ABC-2 build it
  - [ ] ABC-3 docs

Fix the login
  - [ ] write the repro
  - [ ] ABC-7 the fix
X
check "ls: ranks, source, current step marked" \
  'p ls | grep -q "^1\. Ship the export" \
   && p ls | grep -q "^2\. Fix the login" \
   && p ls | grep -q "> Lead 2026-11-09" \
   && p ls | grep -q "\[ \] ABC-2 build it   <- now" \
   && p ls | grep -q "\[ \] write the repro   <- now"'
check "tickets: unchecked steps only" \
  'test "$(p tickets | cut -f1,2 | tr "\t\n" ":,")" = "1:ABC-2,1:ABC-3,2:ABC-7,"'
check "rank: branch, slug and worktree path" \
  'test "$(p rank feat/jrb/abc-2-build)" = 1 \
   && test "$(p rank abc-7-fix)" = 2 \
   && test "$(p rank /r/.worktrees/abc-3-docs/sub)" = 1'
check "rank: none for a checked step or a lookalike ticket" \
  '! p rank abc-1-spike && ! p rank abc-27-other && ! p rank xabc-2'

# Capture: a new outcome goes last; --top goes above the first unpinned.
p add --by Lead --date 2026-11-10 --quote 'say "now"' "Cut costs" \
  "ABC-9 audit" >/dev/null
check "add: new outcome appended last with source and step" \
  'p ls | grep -q "^3\. Cut costs" \
   && grep -q "  > Lead 2026-11-10 - \"say '"'"'now'"'"'\"" "$_f" \
   && grep -q "  - \[ \] ABC-9 audit" "$_f"'
check "add: existing outcome gets only new steps" \
  'p add "ship the export" "ABC-2 build it" "ABC-4 rollout" \
   | grep -q "added 1 step" \
   && test "$(grep -c "ABC-2" "$_f")" = 1 && grep -q "ABC-4 rollout" "$_f"'
check "add: nothing new says so" \
  'p add "Ship the export" "ABC-3" | grep -q "nothing new"'
p add --top "Urgent thing" >/dev/null
check "add --top: rank 1 with nothing pinned" \
  'test "$(p ls | grep "^1\.")" = "1. Urgent thing"'
check "log: a capture snapshot per priority" \
  'test "$(awk -F "\t" "\$2 == \"capture\"" "$_f.log" | tail -4 \
     | cut -f3,4 | tr "\t\n" ":,")" \
     = "1:Urgent thing,2:Ship the export,3:Fix the login,4:Cut costs,"'

# Hand edit: move "Fix the login" to the top, drop "Cut costs" and the
# repro step.
cat > "$_t/next" <<'X'
Fix the login
  - [ ] ABC-7 the fix
Urgent thing
Ship the export
  - [x] ABC-1 spike
  - [ ] ABC-2 build it
  - [ ] ABC-3 docs
  - [ ] ABC-4 rollout
X
p edit
check "edit: moved-up outcome pinned, others not" \
  'test "$(cat "$_f.pinned")" = "Fix the login"'
check "edit: dropped outcome and step logged as removed" \
  'awk -F "\t" "\$2 == \"Cut costs\" && \$3 == \"\"" "$_f.removed" \
     | grep -q . \
   && awk -F "\t" "\$2 == \"Fix the login\" && \$3 == \"write the repro\"" \
     "$_f.removed" | grep -q .'
check "log: hand snapshot of the new order" \
  'test "$(awk -F "\t" "\$2 == \"hand\"" "$_f.log" | cut -f3,4,5 \
     | tr "\t\n" ":,")" \
     = "1:Fix the login:ABC-7,2:Urgent thing:,3:Ship the export:ABC-1 ABC-2 ABC-3 ABC-4,"'

_rc=0; p add "cut costs" "ABC-10" 2>"$_t/err" || _rc=$?
check "add: hand-removed outcome refused, exit 3" \
  'test "$_rc" = 3 && grep -q "removed by hand" "$_t/err" \
   && ! grep -qi "cut costs" "$_f"'
p add "Fix the login" "write the repro" "ABC-8 test" >/dev/null
check "add: hand-removed step not re-added, new one is" \
  '! grep -q "write the repro" "$_f" && grep -q "ABC-8 test" "$_f"'
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
check "brief: each priority, current step, worktree state" \
  'p brief > "$_t/brief"; grep -q "^Today'"'"'s priorities:" "$_t/brief" \
   && grep -q "^1\. Fix the login" "$_t/brief" \
   && grep -q "   now: ABC-7 the fix" "$_t/brief" \
   && grep -q "   abc-7-fix: no agent" "$_t/brief" \
   && grep -A2 "^2\. Another" "$_t/brief" | grep -q "no worktree on it"'

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
