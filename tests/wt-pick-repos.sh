#!/bin/sh
#
# tests/wt-pick-repos.sh [BIN] — RAS-96: `wt :` lists the worktrees of
# every repo with a `.worktrees/` dir under $WT_PROJECTS, from any dir,
# the current repo first and $WT_GROUP labels kept. A fake fzf records
# the rows it is offered and picks nothing. BIN defaults to this
# checkout's bin/.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_bin="${1:-$_root/bin}"
_t="$(cd "$(mktemp -d /tmp/wpick.XXXX)" && pwd -P)"
test -n "${KEEP:-}" || trap 'rm -rf "$_t"' EXIT
unset TMUX TMUX_PANE CLAUDECODE
export LOCAL_CONFIG="$_t/cfg" FAKE="$_t/fake" WT_PROJECTS="$_t/p"
mkdir -p "$LOCAL_CONFIG/worktrees" "$FAKE/bin" "$_t/elsewhere"
printf '#!/bin/sh\ncut -f3 > "$FAKE/rows"\nexit 1\n' > "$FAKE/bin/fzf"
chmod +x "$FAKE/bin/fzf"
export PATH="$FAKE/bin:$_bin:$PATH"
export GIT_CONFIG_COUNT=1 GIT_CONFIG_KEY_0=core.hooksPath \
  GIT_CONFIG_VALUE_0=/dev/null

# repo <path> <branch>: a repo with one worktree on <branch>.
repo() {
  git init -q "$1"
  git -C "$1" commit -q --allow-empty -m init
  git -C "$1" worktree add -q "$1/.worktrees/$2" -b "$2"
}
repo "$_t/p/alpha" a-1
repo "$_t/p/nest/beta" b-1
repo "$_t/p/gamma" g-1
mkdir -p "$_t/p/stale/.worktrees"   # no repo: skipped quietly
printf '# In progress\na-1\n' > "$LOCAL_CONFIG/worktrees/alpha"

_fail=0
check() { if eval "$2"; then echo "ok   $1"; else
  echo "FAIL $1"; _fail=1; fi; }

pick() { (cd "$1" && WT_GROUP="${2:-}" wt : 2>"$FAKE/err"); }

pick "$_t/elsewhere"
check 'outside a repo: every repo, by path' \
  '[ "$(cat "$FAKE/rows")" = "alpha: In progress: a-1
gamma: ⊘ g-1
beta: ⊘ b-1" ]'
check 'no stderr noise' '[ ! -s "$FAKE/err" ]'

pick "$_t/p/gamma/.worktrees/g-1" "be=$_t/p/nest/beta"
check 'current repo first, then WT_GROUP with its label' \
  '[ "$(head -2 "$FAKE/rows")" = "gamma: ⊘ g-1
be: ⊘ b-1" ]'
check 'all three repos listed once' '[ "$(wc -l < "$FAKE/rows")" -eq 3 ]'

exit "$_fail"
