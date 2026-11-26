#!/bin/sh
#
# tests/wt-live.sh [BIN] — RAS-116: in a repo whose main checkout runs
# (git config wt.live, set by repo-sync), `wt done` and `wt ra` refuse
# a merged ticket whose merge commit isn't in that checkout, and park
# it at Needs live verification. Temp repo and LOCAL_CONFIG; tmux,
# Linear, gh and the other neighbours are logging fakes.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_bin="${1:-$_root/bin}"
_t="$(mktemp -d /tmp/wlive.XXXX)"
test -n "${KEEP:-}" || trap 'rm -rf "$_t"' EXIT
unset TMUX TMUX_PANE CLAUDECODE
export LOCAL_CONFIG="$_t/cfg" FAKE="$_t/fake"
mkdir -p "$LOCAL_CONFIG/worktrees" "$FAKE/bin"
for c in tmux notif notify tsp docker-slot wt-tell lin \
  tmux-session-name-from-path jrb-hook gh; do
  printf '#!/bin/sh\necho "%s $*" >> "$FAKE/calls"\n' "$c" \
    > "$FAKE/bin/$c"
  chmod +x "$FAKE/bin/$c"
done
echo 'test "$1" = id && echo ABC-1; exit 0' >> "$FAKE/bin/lin"
echo 'exit 1' >> "$FAKE/bin/wt-tell"
echo 'basename "$1"' >> "$FAKE/bin/tmux-session-name-from-path"
# gh: a merged PR's merge commit is $FAKE/merge-<branch's last part>.
echo '
case "$*" in *mergeCommit*) for a; do test "$p" = --head && br="$a"
p="$a"; done; cat "$FAKE/merge-${br##*/}" 2>/dev/null ;; esac' \
  >> "$FAKE/bin/gh"
export PATH="$FAKE/bin:$_bin:$PATH"
export GIT_CONFIG_COUNT=1 GIT_CONFIG_KEY_0=core.hooksPath \
  GIT_CONFIG_VALUE_0=/dev/null GIT_AUTHOR_NAME=t GIT_AUTHOR_EMAIL=t@t \
  GIT_COMMITTER_NAME=t GIT_COMMITTER_EMAIL=t@t

_fail=0
check() { if eval "$2"; then echo "ok   $1"; else echo "FAIL $1"; _fail=1; fi; }

# Repo `app`, main checkout live; worktrees x and y with PRs merged
# (squash commits on origin/main) the main checkout hasn't pulled.
git init -q --bare -b main "$_t/origin.git"
git clone -q "$_t/origin.git" "$_t/app" 2>/dev/null
_r="$_t/app"
git -C "$_r" commit -q --allow-empty -m init
git -C "$_r" push -q origin HEAD:main 2>/dev/null
git -C "$_r" config wt.live true
git clone -q "$_t/origin.git" "$_t/dev"
for s in x y; do
  git -C "$_r" worktree add -q -b "fix/jrb/$s" "$_r/.worktrees/$s"
  git -C "$_r/.worktrees/$s" push -q origin "fix/jrb/$s" 2>/dev/null
  git -C "$_t/dev" commit -q --allow-empty -m "$s (#1)"
  git -C "$_t/dev" push -q origin HEAD:main
  git -C "$_t/dev" rev-parse HEAD > "$FAKE/merge-$s"
done
_of="$LOCAL_CONFIG/worktrees/app"
printf '%s\n' '# IN PROGRESS' fix/jrb/x fix/jrb/y '# PROD REVIEW' > "$_of"
insec() { awk -v s="# $1" -v r="$2" '/^# /{c=$0} $0==r{f=(c==s)}
  END{exit !f}' "$_of"; }
wt_() { (cd "$_r/.worktrees/$1" && shift && wt "$@") 2>>"$_t/err"; }

echo '# not live yet'
wt_ x done && _rc=0 || _rc=$?
check 'wt done refuses' 'test "$_rc" != 0'
check 'worktree stays' 'test -d "$_r/.worktrees/x"'
check 'says the merge commit is not in the checkout' \
  'grep -q "isn.t in .*/app yet" "$_t/err"'
check 'ticket not Done' '! grep -q "^lin state Done" "$FAKE/calls"'
check 'ticket at Needs live verification' \
  'grep -q "^lin state Needs live verification ABC-1" "$FAKE/calls"'
check 'row parked in PROD REVIEW' 'insec "PROD REVIEW" fix/jrb/x'
wt_ y ra && _rc=0 || _rc=$?
check 'wt ra refuses too' 'test "$_rc" != 0'
check 'and parks it in PROD REVIEW' 'insec "PROD REVIEW" fix/jrb/y'
check 'Needs announcement not set' \
  '! grep -q "^lin state Needs announcement" "$FAKE/calls"'

echo '# live'
git -C "$_r" pull -q --ff-only origin main
wt_ y ra && _rc=0 || _rc=$?
check 'wt ra passes' 'test "$_rc" = 0 && insec "TO ANNOUNCE" fix/jrb/y'
wt_ x done && _rc=0 || _rc=$?
check 'wt done passes' 'test "$_rc" = 0'
check 'ticket Done' 'grep -q "^lin state Done ABC-1" "$FAKE/calls"'

echo '# repo not marked live'
git -C "$_r" config --unset wt.live
git -C "$_r" worktree add -q -b fix/jrb/z "$_r/.worktrees/z"
git -C "$_r/.worktrees/z" push -q origin fix/jrb/z 2>/dev/null
echo deadbeefdeadbeefdeadbeefdeadbeefdeadbeef > "$FAKE/merge-z"
echo fix/jrb/z >> "$_of"
: > "$FAKE/calls"
wt_ z done && _rc=0 || _rc=$?
check 'wt done passes without a check' \
  'test "$_rc" = 0 && ! grep -q mergeCommit "$FAKE/calls"'

test "$_fail" = 0 && { echo "all passed"; exit 0; }
cat "$_t/err"
exit 1
