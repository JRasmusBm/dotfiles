#!/bin/sh
#
# tests/prio-badge-warn.sh [BIN] — a worktree on a priority shows
# `P0 #N` first in its tmux badge (wt-badge), its section in `# P0`
# being the one it came from; `prio warn` (what `wt feat|fix` runs
# first) warns on stderr, never blocking, when the new branch is on no
# priority while a priority's worktree stalls or has no agent. A temp
# git repo and LOCAL_CONFIG; tmux is a fake listing one Claude pane.
# BIN defaults to this checkout's bin/.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_bin="${1:-$_root/bin}"
_t="$(mktemp -d /tmp/tpw.XXXX)"
trap 'rm -rf "$_t"' EXIT
unset TMUX TMUX_PANE
export LOCAL_CONFIG="$_t/cfg"
mkdir -p "$LOCAL_CONFIG/worktrees" "$_t/bin"
_r="$_t/repo"
cat > "$_t/bin/tmux" <<X
#!/bin/sh
test "\$1" = list-panes && cat "$_t/panes" 2>/dev/null
exit 0
X
chmod +x "$_t/bin/tmux"
export PATH="$_t/bin:$_bin:$PATH"

_fail=0
ok() { echo "ok   $1"; }
no() { echo "FAIL $1: $2"; _fail=1; }
is() { test "$2" = "$3" && ok "$1" || no "$1" "$2"; }

git init -q -b main "$_r"
git -C "$_r" -c core.hooksPath=/dev/null -c user.email=t@t -c user.name=t \
  commit -q --allow-empty -m i
git -C "$_r" worktree add -q -b feat/jrb/abc-2-two "$_r/.worktrees/abc-2-two"
git -C "$_r" worktree add -q -b feat/jrb/other "$_r/.worktrees/other"
_b="$LOCAL_CONFIG/worktrees/repo"
printf '# P0\nfeat/jrb/abc-2-two\n# IN PROGRESS\nfeat/jrb/other\n' > "$_b"
printf 'feat/jrb/abc-2-two\tTEAM REVIEW\n' > "$_b.p0"
printf 'One\n  - [ ] ABC-1 a\nTwo\n  - [ ] ABC-2 b\n' \
  > "$LOCAL_CONFIG/priorities"

is "badge: P0 #N, then the section it came from" \
  "$(wt-badge "$_r/.worktrees/abc-2-two")" \
  "#[fg=red,bold]P0 ##2#[default] #[fg=cyan]team review "
is "badge: off any priority, as before" \
  "$(wt-badge "$_r/.worktrees/other")" "#[fg=yellow]in progress "
printf 'abc-2-two\tfeat/jrb/abc-2-two\tother\n' > "$_b.blocked"
is "badge: P0 #N before blocked" \
  "$(wt-badge "$_r/.worktrees/abc-2-two")" \
  "#[fg=red,bold]P0 ##2#[default] #[fg=red]blocked "
rm "$_b.blocked"

prio warn feat/jrb/new-thing 2> "$_t/err"; _rc=$?
is "warn: exit 0 (never blocks)" "$_rc" 0
grep -q 'P0 #2 Two: abc-2-two (no agent)' "$_t/err" \
  && ok "warn: names the P0 worktree with no agent" \
  || no "warn: no agent" "$(cat "$_t/err")"
prio warn feat/jrb/abc-1-new 2> "$_t/err"
is "warn: silent for a branch on a priority" "$(cat "$_t/err")" ""

printf 'claude\t%s\n' "$_r/.worktrees/abc-2-two" > "$_t/panes"
prio warn feat/jrb/new-thing 2> "$_t/err"
is "warn: silent while the P0 worktree's agent runs" "$(cat "$_t/err")" ""
printf '{"items":[{"slug":"abc-2-two","state":"STALLED","why":"idle 2h"}]}' \
  > "$LOCAL_CONFIG/wt-cold-last"
prio warn feat/jrb/new-thing 2> "$_t/err"
grep -q 'abc-2-two (stalled: idle 2h)' "$_t/err" \
  && ok "warn: names a stalled P0 worktree" \
  || no "warn: stalled" "$(cat "$_t/err")"

exit "$_fail"
