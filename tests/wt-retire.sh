#!/bin/sh
#
# tests/wt-retire.sh [BIN] — RAS-40: a PROD REVIEW row whose ticket is
# Done or Canceled leaves the board (`wt retire`, called by wt-cold) and
# is never pinged; open ones keep their ping. Nothing real is touched:
# LOCAL_CONFIG, the repo and its origin are a temp dir, and tmux, notif,
# Linear and the other neighbours are logging fakes first on PATH. BIN
# defaults to this checkout's bin/.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_bin="${1:-$_root/bin}"
_t="$(mktemp -d /tmp/wret.XXXX)"
test -n "${KEEP:-}" || trap 'rm -rf "$_t"' EXIT
unset TMUX TMUX_PANE
export LOCAL_CONFIG="$_t/cfg" FAKE="$_t/fake"
mkdir -p "$LOCAL_CONFIG/worktrees" "$FAKE/bin"
for c in tmux notif notify tsp docker-slot wt-tell lin \
  tmux-session-name-from-path jrb-hook gh; do
  printf '#!/bin/sh\necho "%s $*" >> "$FAKE/calls"\n' "$c" \
    > "$FAKE/bin/$c"
  chmod +x "$FAKE/bin/$c"
done
# No Linear: `lin id` fails, so wt never writes a ticket.
echo 'exit 1' >> "$FAKE/bin/lin"
echo 'exit 1' >> "$FAKE/bin/wt-tell"
echo 'basename "$1"' >> "$FAKE/bin/tmux-session-name-from-path"
# gh: a PR's head is $FAKE/pr-<last path part of the branch>.
echo '
case "$*" in *--head*) for a; do test "$p" = --head && br="$a"; p="$a"
done; cat "$FAKE/pr-${br##*/}" 2>/dev/null ;; esac' >> "$FAKE/bin/gh"
export PATH="$FAKE/bin:$_bin:$PATH"
# My global hooks prompt on /dev/tty; this repo is scratch.
export GIT_CONFIG_COUNT=1 GIT_CONFIG_KEY_0=core.hooksPath \
  GIT_CONFIG_VALUE_0=/dev/null

_fail=0
ok() { echo "ok   $1"; }
no() { echo "FAIL $1"; _fail=1; }
check() { if eval "$2"; then ok "$1"; else no "$1"; fi; }

# A repo `app` with an origin; worktrees: clean (pushed), dirty,
# ahead (unpushed commit). Rows `gone` and `dep` have no worktree;
# `dep` is blocked on `gone`.
git init -q --bare "$_t/origin.git"
git clone -q "$_t/origin.git" "$_t/app" 2>/dev/null
_r="$_t/app"
git -C "$_r" commit -q --allow-empty -m init
git -C "$_r" push -q origin HEAD 2>/dev/null
for s in clean dirty ahead squashed; do
  git -C "$_r" worktree add -q -b "fix/jrb/$s" "$_r/.worktrees/$s"
  git -C "$_r/.worktrees/$s" push -q origin "fix/jrb/$s" 2>/dev/null
done
echo x > "$_r/.worktrees/dirty/x"
git -C "$_r/.worktrees/ahead" commit -q --allow-empty -m local
# Squash-merged, remote branch deleted: its commit is on no remote,
# but it is its PR's head.
git -C "$_r/.worktrees/squashed" commit -q --allow-empty -m pr
git -C "$_r/.worktrees/squashed" rev-parse HEAD > "$FAKE/pr-squashed"
_of="$LOCAL_CONFIG/worktrees/app"
printf '%s\n' '# IN PROGRESS' fix/jrb/dep '# PROD REVIEW' \
  fix/jrb/clean fix/jrb/dirty fix/jrb/ahead fix/jrb/squashed \
  fix/jrb/gone \
  fix/jrb/open > "$_of"
printf 'dep\tfix/jrb/dep\tgone\tfix/jrb/gone\n' \
  > "$LOCAL_CONFIG/worktrees/app.blocked"
printf 'gone\tfix/jrb/gone\t2026-01-01T00:00\twhat\t1\t\n' \
  > "$LOCAL_CONFIG/worktrees/app.waiting"

retire() { (cd "$_r" && wt retire "$1" "$2") 2>>"$_t/err"; }
onboard() { grep -qx "$1" "$_of"; }

echo '# wt retire'
retire fix/jrb/gone Done
check 'row with no worktree leaves the board' '! onboard fix/jrb/gone'
check 'its w8 row is dropped' \
  '! grep -q "^gone	" "$LOCAL_CONFIG/worktrees/app.waiting"'
check 'what was blocked on it goes back in progress' \
  'awk "/^# IN PROGRESS/{s=1} s&&/fix\/jrb\/dep/{f=1} END{exit !f}" "$_of"'
check 'and its block is dropped' \
  '! test -s "$LOCAL_CONFIG/worktrees/app.blocked"'
check 'Linear untouched (no lin state)' '! grep -q "^lin state" "$FAKE/calls"'

retire fix/jrb/clean Done
sleep 2  # eviction runs detached
check 'clean, pushed worktree leaves the board' '! onboard fix/jrb/clean'
check 'and leaves the disk' '! test -d "$_r/.worktrees/clean"'
check 'registered as Done, so wt resume brings it back' \
  'grep -q "^clean	fix/jrb/clean	.*	Done$" "$LOCAL_CONFIG/worktrees/app.registry"'

retire fix/jrb/dirty Canceled
check 'dirty worktree leaves the board' '! onboard fix/jrb/dirty'
check 'but stays on disk with its file' 'test -f "$_r/.worktrees/dirty/x"'
retire fix/jrb/ahead Done
check 'unpushed commit: off the board' '! onboard fix/jrb/ahead'
check 'but its branch stays' \
  'git -C "$_r" rev-parse -q --verify fix/jrb/ahead >/dev/null'
check 'it says why it kept them' \
  'test "$(grep -c "keeping .* on disk" "$_t/err")" = 2'
retire fix/jrb/squashed Done
sleep 2
check 'commits only its PR holds: removed like a pushed one' \
  '! onboard fix/jrb/squashed && ! test -d "$_r/.worktrees/squashed"'
check 'open row untouched' 'onboard fix/jrb/open'

echo '# wt-cold: which PROD REVIEW rows leave'
python3 - "$_bin/wt-cold" <<'EOF' || _fail=1
import importlib.machinery as m, importlib.util as u, sys
l = m.SourceFileLoader('c', sys.argv[1])
s = u.spec_from_loader('c', l)
c = u.module_from_spec(s)
l.exec_module(c)
c._tickets.update({'ABC-1': ('completed', 0), 'ABC-2': ('canceled', 0),
                   'ABC-3': ('started', 0), 'ABC-4': None})
c.pane_state = lambda pid: (pid == 'busy', False, '')


class B:
    claude, root, repo = [], '/nowhere', 'app'
    prs = {'test/jrb/e2e': {'number': 7, 'state': 'MERGED'},
           'test/jrb/live': {'number': 8, 'state': 'OPEN'}}


def it(br, path=None):
    return dict(branch=br, slug=br.rsplit('/', 1)[-1], path=path,
                sec='PROD REVIEW')


fail = 0
for br, path, panes, want in [
        ('fix/jrb/abc-1-x', None, [], ('Done', 'ABC-1 done')),
        ('fix/jrb/abc-2-x', '/wt/p2', [], ('Canceled', 'ABC-2 canceled')),
        ('fix/jrb/abc-3-x', None, [], None),
        ('fix/jrb/abc-4-x', None, [], None),  # Linear can't say
        ('fix/jrb/abc-1-y', None, [('busy', 'abc-1-y', '/x')], None),
        ('test/jrb/e2e', None, [],
         ('Done', 'no ticket, #7 merged, no worktree')),
        ('test/jrb/e2e', '/wt/e2e', [], None),
        ('test/jrb/live', None, [], None)]:
    b = B()
    b.claude = panes
    got = c.work_closed(b, it(br, path))
    print(('ok  ' if got == want else 'FAIL') +
          f' {br} {path or ""} {panes and "busy" or ""}-> {got}')
    fail |= got != want
b = B()
x = it('fix/jrb/abc-1-x')
c.judge(b, x, {})
print(('ok  ' if x['state'] == 'REMOVED' and x['ended'] == 'Done'
       else 'FAIL') + ' judge marks it REMOVED, before any other state')
fail |= x['state'] != 'REMOVED'
sys.exit(fail)
EOF

exit "$_fail"
