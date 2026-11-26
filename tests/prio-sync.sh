#!/bin/sh
#
# tests/prio-sync.sh [BIN] — `prio sync` reads each priority's tickets
# from its Linear groupings into the cache (only mine, open or done in
# the last week; a failed grouping keeps what it had; a failed read
# says so in ls), snapshots the log when the open tickets change, sends
# an unlinked priority to the linking agent (once an hour), and asks
# the guessing agent about my new tickets in no grouping: a guess is an
# inbox row whose popup (`prio guess`) joins the ticket in Linear or
# rejects it, and clears the row. A ticket with no project joins what
# its parent chain sits in, or (no parent) what all its related tickets
# sit in, without asking; one still in none with a board row gets a
# `P?` row, once. Real notify/notif on a temp
# LOCAL_CONFIG; tmux, osascript and afplay log; Linear is
# tests/prio-linear-fake and claude a fake answering from a file. BIN
# defaults to this checkout's bin/.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_bin="${1:-$_root/bin}"
_t="$(mktemp -d /tmp/tpy.XXXX)"
test -n "${KEEP:-}" && echo "$_t" || trap 'rm -rf "$_t"' EXIT
unset TMUX TMUX_PANE
export LOCAL_CONFIG="$_t/cfg"
mkdir -p "$LOCAL_CONFIG/worktrees" "$_t/bin"
for c in tmux osascript afplay focus-log; do
  printf '#!/bin/sh\necho "%s $*" >> "%s/calls"\n' "$c" "$_t" \
    > "$_t/bin/$c"
done
# The fake claude answers $_t/<model>.json and logs its tools.
cat > "$_t/bin/claude" <<X
#!/bin/sh
m=""; tools=""; p=""
while test \$# -gt 0; do
  case "\$1" in
    -p) p="\$2"; shift ;;
    --model) m="\$2"; shift ;;
    --allowedTools) tools="\$2"; shift ;;
  esac
  shift
done
echo "claude \$m \$tools" >> "$_t/calls"
printf '%s\n' "\$p" > "$_t/\$m.prompt"
printf '{"is_error": false, "structured_output": %s}\n' "\$(cat "$_t/\$m.json")"
X
chmod +x "$_t/bin/"*
export PATH="$_t/bin:$_bin:$PATH" PRIO_CLAUDE="$_t/bin/claude" \
  PRIO_LINEAR_CMD="$_root/tests/prio-linear-fake" PRIO_FAKE="$_t/linear.json"
_f="$LOCAL_CONFIG/priorities"
_inbox="$LOCAL_CONFIG/notifications"

_fail=0
ok() { echo "ok   $1"; }
no() { echo "FAIL $1"; _fail=1; }
check() { if eval "$2"; then ok "$1"; else no "$1"; fi; }
cache() { cut -f1,2,3 "$_f.tickets" | tr '\t\n' ':,'; }
refs() { cut -f10 "$_inbox" 2>/dev/null | grep . | tr '\n' ' '; }
# Waits up to 10s for a detached agent run to leave its mark.
until_() { _n=0; until eval "$1" || test "$_n" -ge 50; do
  sleep 0.2; _n=$((_n + 1)); done; }

cat > "$_t/linear.json" <<'X'
{"label:one": ["ABC-1 started me one", "ABC-2 completed me done lately",
   "ABC-3 completed me old done long ago", "ABC-4 canceled me dropped",
   "ABC-5 started - not mine"],
 "parent:ABC-10": [{"id": "ABC-11 started me child",
   "kids": ["ABC-12 unstarted me grandchild", "ABC-1 started me twice"]}],
 "new": []}
X
cat > "$_f" <<'X'
One
  in label:one
Two
  in ABC-10
X
"$_bin/prio" sync
check "cache: mine, open or done this week, two levels of sub-issues" \
  'test "$(cache)" = "One:ABC-1:open,One:ABC-2:done,Two:ABC-11:open,Two:ABC-12:open,Two:ABC-1:open,"'
check "a ticket under two priorities counts for the higher" \
  'test "$("$_bin/prio" rank abc-1-x)" = 1'
check "log: a linear snapshot of the change" \
  'test "$(awk -F "\t" "\$2 == \"linear\"" "$_f.log" | cut -f3,5 \
     | tr "\t\n" ":,")" = "1:ABC-1,2:ABC-11 ABC-12 ABC-1,"'
check "guesses: first run sets the cursor, asks nothing" \
  'grep -q "^-	cursor" "$_f.guesses" \
   && ! grep -qs "claude haiku" "$_t/calls"'
"$_bin/prio" sync
check "log: nothing changed, no snapshot" \
  'test "$(awk -F "\t" "\$2 == \"linear\"" "$_f.log" | wc -l)" -eq 2'

sed -i '' 's/"fail": \[\]//; s/^{/{"fail": ["parent:ABC-10"],/' "$_t/linear.json"
sed -i '' 's/"ABC-1 started me one", //' "$_t/linear.json"
"$_bin/prio" sync
check "a failed grouping keeps its rows, the others update" \
  'test "$(cache)" = "One:ABC-2:done,Two:ABC-11:open,Two:ABC-12:open,Two:ABC-1:open,"'
check "the move of ABC-1 to rank 2 is in the log" \
  'test "$(awk -F "\t" "\$2 == \"linear\"" "$_f.log" | tail -2 | cut -f3,5 \
     | tr "\t\n" ":,")" = "1:,2:ABC-11 ABC-12 ABC-1,"'
PRIO_LINEAR_CMD=false "$_bin/prio" sync
check "a failed read: cache kept, ls says so" \
  'test "$(cache)" = "One:ABC-2:done,Two:ABC-11:open,Two:ABC-12:open,Two:ABC-1:open," \
   && "$_bin/prio" ls | grep -q "^Linear: last read failed"'
sed -i '' 's/"fail": \["parent:ABC-10"\],//' "$_t/linear.json"
"$_bin/prio" sync
check "the next good read clears the warning" \
  '! "$_bin/prio" ls | grep -q "last read failed"'

# Linking: an outcome with no grouping goes to the agent.
cat > "$_t/sonnet.json" <<'X'
{"create": {"team": "abc", "title": "Three, done"},
 "adopt": ["ABC-20", "ABC-21", "ABC-22"], "reason": "r"}
X
cat > "$_t/linear.json" <<'X'
{"label:one": [], "parent:ABC-10": [],
 "parent:ABC-900": ["ABC-20 started me adopted"],
 "issues": {"ABC-20": {"assignee": {"isMe": true}, "parent": null},
            "ABC-21": {"assignee": {"isMe": false}, "parent": null},
            "ABC-22": {"assignee": {"isMe": true}, "parent": {"id": "p"}},
            "ABC-900": {"assignee": {"isMe": true}, "parent": null},
            "ABC-10": {"assignee": {"isMe": true}, "parent": null}},
 "new": []}
X
printf 'Three\n  - ABC-20 is a hint\n' >> "$_f"
"$_bin/prio" sync
until_ 'grep -q "	linked	" "$_f.links" 2>/dev/null'
check "link: a parent created in the team, assigned to me" \
  'grep -q "^create team-ABC Three, done$" "$_t/linear.json.calls"'
check "link: adopts only my open tickets with no parent" \
  'test "$(grep -c "^update" "$_t/linear.json.calls")" = 1 \
   && grep -q "^update id-ABC-20 {\"parentId\": \"id-ABC-900\"}" \
     "$_t/linear.json.calls"'
check "link: the agent may only run prio linear" \
  'grep -q "claude sonnet Bash(.*/prio linear \*)" "$_t/calls"'
check "link: the grouping is written under the outcome" \
  'test "$(sed -n "/^Three/,\$p" "$_f" | tr "\n" "|")" \
     = "Three|  in ABC-900   # created|  - ABC-20 is a hint|"'
check "changes: the parent created and the ticket adopted" \
  'test "$(cut -f2-6 "$_f.changes" | tr "\t\n" ":,")" \
     = "link:created:ABC-900::Three,link:joined:ABC-20:ABC-900:Three," \
   && "$_bin/prio" changes | grep -q "link   moved ABC-20 into ABC-900  (Three)"'
"$_bin/prio" sync
check "link: next sync reads the new grouping" \
  'grep -q "^Three	ABC-20	open" "$_f.tickets"'

printf '{"reason": "nothing yet"}' > "$_t/sonnet.json"
printf 'Four\n' >> "$_f"
"$_bin/prio" sync
until_ 'grep -q "Four	none" "$_f.links" 2>/dev/null'
check "link: none found shows in ls" \
  '"$_bin/prio" ls | grep -A1 "^4\. Four" \
     | grep -q "the agent found none: nothing yet"'
"$_bin/prio" sync
check "link: not retried within the hour" \
  'test "$(grep -c "claude sonnet" "$_t/calls")" = 2'

# Guessing: my new tickets in no grouping.
sed -i '' 's/"new": \[\]/"new": ["ABC-30 started me new one", "ABC-31 started me new two", "ABC-20 started me in three"]/' \
  "$_t/linear.json"
python3 - "$_t/linear.json" <<'X'
import json, sys
d = json.load(open(sys.argv[1]))
for t in ('ABC-30', 'ABC-31'):
    d['issues'][t] = {'assignee': {'isMe': True}, 'parent': None}
json.dump(d, open(sys.argv[1], 'w'))
X
printf '{"guesses": [{"ticket": "ABC-30", "rank": 2}, {"ticket": "ABC-31", "rank": 0}]}' \
  > "$_t/haiku.json"
"$_bin/prio" sync
until_ 'grep -q "^ABC-31	none" "$_f.guesses" 2>/dev/null'
until_ 'test -n "$(refs)"'
check "guess: only tickets in no grouping are asked about" \
  'grep -q "^ABC-30	asked	2" "$_f.guesses" \
   && grep -q "^ABC-31	none	0" "$_f.guesses" \
   && ! grep -q "^ABC-20" "$_f.guesses"'
check "guess: one inbox row, for the confident guess" \
  'test "$(refs)" = "prio:two:abc-30 "'
"$_bin/prio" sync
check "guess: asked once" \
  'test "$(grep -c "claude haiku" "$_t/calls")" = 1 \
   && test "$(refs)" = "prio:two:abc-30 "'
printf '\n' | "$_bin/prio" guess ABC-30 >/dev/null
check "guess: Enter leaves it for later" \
  'test "$(refs)" = "prio:two:abc-30 "'
printf 'y\n' | "$_bin/prio" guess abc-30 >/dev/null
check "guess: y joins the ticket to the guessed priority's grouping" \
  'grep -q "^update id-ABC-30 {\"parentId\": \"id-ABC-10\"}" \
     "$_t/linear.json.calls" && grep -q "^ABC-30	accepted	2" "$_f.guesses"'
check "changes: an accepted guess is logged" \
  'tail -1 "$_f.changes" | cut -f2-5 | grep -q "^guess	joined	ABC-30	ABC-10$"'
check "guess: settled, its row is gone" 'test -z "$(refs)"'

# A stale prio: row (an old step row) goes on the next sync.
NOTIFY_CLASS=step NOTIFY_CTX=prio:one:write-the-spec \
  NOTIFY_REF=prio:one:write-the-spec NOTIFY_MODE=sticky \
  notify "P0" "write the spec" >/dev/null 2>&1
test -n "$(refs)" || no "setup: the old row is there"
"$_bin/prio" sync
check "sync: drops prio rows that are no open guess" 'test -z "$(refs)"'

# Inheriting: EXP-1456's shape (related tickets all in one project) and
# EXP-1480's (its parent in it), a split ticket, a ticket on a board.
printf 'Onb\n  in https://linear.app/x/project/onb-aaa111aaa111\n' >> "$_f"
python3 - "$_t/linear.json" <<'X'
import json, sys
d = json.load(open(sys.argv[1]))
onb = {'identifier': 'ABC-41', 'team': {'key': 'ABC'}, 'project': {'slugId': 'aaa111aaa111',
                                           'name': 'Onb'}}
also = {'identifier': 'ABC-42', 'team': {'key': 'ABC'}, 'project': {'slugId': 'aaa111aaa111'}}
loose = {'identifier': 'ABC-43', 'project': None}
one = {'identifier': 'ABC-47', 'team': {'key': 'ABC'}, 'labels': {'nodes': [{'name': 'One'}]}}
rel = lambda *xs: {'nodes': [{'type': 'related', 'relatedIssue': x}
                             for x in xs]}
d['new'] = ['ABC-40 started me combined branch',
            'ABC-44 started me follow-up', 'ABC-45 started me split',
            'ABC-46 started me on a board', 'ABC-49 started me next',
            'ABC-50 started me closed since']
d['issues'].update({
    'ABC-40': {'title': 'combined branch', 'description': 'Folds\nsteps',
               'team': {'key': 'ABC'},
               'relations': rel(onb, loose), 'inverseRelations': {
                   'nodes': [{'type': 'related', 'issue': also}]}},
    'ABC-44': {'title': 'follow-up', 'parent': {
        'identifier': 'ABC-40', 'parent': {'identifier': 'ABC-48',
                                           'labels': {'nodes': [
                                               {'name': 'one'}]}}}},
    'ABC-45': {'title': 'split', 'description': 'Line one\n\nLine two',
               'team': {'key': 'ABC'},
               'relations': rel(onb, one)},
    'ABC-49': {'title': 'next', 'parent': {
        'identifier': 'ABC-51', 'team': {'key': 'ABC'},
        'relations': rel(onb)}},
    'ABC-50': {'title': 'closed since', 'state': {'type': 'completed'}},
    'ABC-46': {'title': 'on a board', 'team': {'key': 'XYZ'},
               'relations': rel(onb)},
    'ABC-31': {'title': 'new two', 'relations': rel(loose)}})
json.dump(d, open(sys.argv[1], 'w'))
X
printf '{"guesses": [{"ticket": "ABC-45", "rank": 0}, {"ticket": "ABC-46", "rank": 0}]}' \
  > "$_t/haiku.json"
printf 'TODO:\nfeat/abc-46-on-a-board\n' > "$LOCAL_CONFIG/worktrees/repo"
"$_bin/prio" sync
until_ 'grep -q "^ABC-46	asked" "$_f.guesses" 2>/dev/null'
until_ 'test "$(refs)" = "prio::abc-46 "'
check "inherit: related tickets all in one project join it, unasked" \
  'grep -q "^update id-ABC-40 {\"projectId\": \"proj-aaa111aaa111\"}" \
     "$_t/linear.json.calls" && grep -q "^ABC-40	joined	5" "$_f.guesses"'
check "inherit: the nearest ancestor in a grouping wins (label one)" \
  'grep -q "^label id-ABC-44 label-one" "$_t/linear.json.calls" \
   && grep -q "^ABC-44	joined	1" "$_f.guesses"'
check "inherit: a parent in none lends its related tickets' grouping" \
  'grep -q "^update id-ABC-49 {\"projectId\": \"proj-aaa111aaa111\"}" \
     "$_t/linear.json.calls"'
check "changes: the inherited joins say so" \
  'test "$(grep -c "	inherit	joined	ABC-4[049]	" "$_f.changes")" = 3'
check "a ticket closed by the time it is placed is left alone" \
  'grep -q "^ABC-50	closed" "$_f.guesses" \
   && ! grep -q "ABC-50" "$_t/haiku.prompt"'
check "inherit: related tickets split over two priorities go to the guess" \
  'grep -q "^ABC-45	none	0" "$_f.guesses" \
   && ! grep -q "id-ABC-45" "$_t/linear.json.calls"'
check "guess: sees the description and the linked tickets' places" \
  'grep -q "^  Line one / Line two | related ABC-41 in Onb; related ABC-47 in no project$" \
     "$_t/haiku.prompt" && ! grep -q "ABC-40" "$_t/haiku.prompt"'
check "inherit: related tickets in another team don't count" \
  '! grep -q "^update id-ABC-46" "$_t/linear.json.calls"'
check "guess: none on a ticket with a board row asks which, once" \
  'grep -q "^ABC-46	asked	0" "$_f.guesses" \
   && grep -q "ABC-46 on a board -> which priority?" "$_inbox"'
"$_bin/prio" sync
check "ask: the row stays while it is open" 'test "$(refs)" = "prio::abc-46 "'
printf '5\n' | "$_bin/prio" guess ABC-46 >/dev/null
check "ask: a digit joins it there and clears the row" \
  'grep -q "^update id-ABC-46 {\"projectId\": \"proj-aaa111aaa111\"}" \
     "$_t/linear.json.calls" && test -z "$(refs)"'

printf '{"guesses": [{"ticket": "ABC-31", "rank": 0}]}' > "$_t/haiku.json"
printf 'TODO:\nfeat/abc-31-new-two\nfeat/abc-24-placed\n' \
  > "$LOCAL_CONFIG/worktrees/repo"
printf 'ABC-24\tnone\t0\t1\n' >> "$_f.guesses"
sed -i '' 's/"label:one": \[\]/"label:one": ["ABC-24 started me placed by hand"]/' \
  "$_t/linear.json"
"$_bin/prio" sync
until_ 'grep -q "^ABC-31	asked" "$_f.guesses" 2>/dev/null'
check "recheck: an old none that got a board row is asked, title read" \
  'grep -q "^ABC-31	asked	0" "$_f.guesses" \
   && grep -q "^ABC-31 new two$" "$_t/haiku.prompt"'
"$_bin/prio" sync
check "recheck: not a none since placed by hand" \
  '! grep -q "^ABC-24	pending" "$_f.guesses"'
check "recheck: once" \
  'test "$(grep -c "^ABC-31	" "$_f.guesses")" = 4'

exit "$_fail"
