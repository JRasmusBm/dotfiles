#!/bin/sh
#
# tests/repo-sync.sh [BIN] — RAS-116: bin/repo-sync keeps a live
# checkout on origin/main. A bare origin, a dev clone that merges PRs
# and a "live" clone on main, in a temp dir; notify logs to a file.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_sync="${1:-$_root/bin}/repo-sync"
_t="$(mktemp -d /tmp/rsync.XXXX)"
test -n "${KEEP:-}" || trap 'rm -rf "$_t"' EXIT
_fails=0

mkdir "$_t/bin"
printf '#!/bin/sh\nprintf "%%s|%%s|%%s\\n" "$NOTIFY_CLASS" "$1" "$2" >> "%s/notified"\n' \
  "$_t" > "$_t/bin/notify"
chmod +x "$_t/bin/notify"
export PATH="$_t/bin:$PATH" LOCAL_CONFIG="$_t/cfg"
export GIT_AUTHOR_NAME=t GIT_AUTHOR_EMAIL=t@t GIT_COMMITTER_NAME=t \
  GIT_COMMITTER_EMAIL=t@t
# The global hooks ask on a tty before a commit on main.
export GIT_CONFIG_COUNT=1 GIT_CONFIG_KEY_0=core.hooksPath \
  GIT_CONFIG_VALUE_0=/dev/null

check() {
  if test "$2" = "$3"; then echo "ok   $1"
  else echo "FAIL $1: got '$2', want '$3'"; _fails=$((_fails + 1)); fi
}
L() { git -C "$_t/live" "$@"; }
head_() { L rev-parse HEAD; }
# pr <n> <file> <line>: PR #n merged into origin/main.
_n=0
pr() {
  git -C "$_t/dev" pull -q --rebase origin main
  echo "$3" >> "$_t/dev/$2"
  git -C "$_t/dev" add "$2"
  git -C "$_t/dev" commit -q -m "$2: $3 (#$1)"
  git -C "$_t/dev" push -q origin main
}
# local_ <file> <line>: a commit made in the live checkout.
local_() {
  echo "$2" >> "$_t/live/$1"
  L add "$1"
  L commit -q -m "local $1: $2"
}
notified() { wc -l < "$_t/notified" | tr -d ' '; }
sync_() { "$_sync" "$@" "$_t/live"; }

git init -q --bare -b main "$_t/origin.git"
git init -q -b main "$_t/dev"
git -C "$_t/dev" remote add origin "$_t/origin.git"
echo base > "$_t/dev/a"
echo base > "$_t/dev/b"
git -C "$_t/dev" add a b
git -C "$_t/dev" commit -q -m base
git -C "$_t/dev" push -q -u origin main
git clone -q "$_t/origin.git" "$_t/live"
: > "$_t/notified"

# 1. Nothing to do: no change, no log; marks the checkout live.
_h="$(head_)"
sync_
check "idle: HEAD unchanged" "$(head_)" "$_h"
check "idle: no log" \
  "$(test -s "$_t/cfg/repo-sync/live/log" && echo y || echo n)" n
check "idle: marked live" "$(L config --bool wt.live)" true

# 2. A merged PR reaches the live checkout in one run.
pr 1 a pr1
sync_
check "merged: at origin" "$(head_)" "$(L rev-parse origin/main)"
check "merged: file live" "$(tail -1 "$_t/live/a")" pr1

# 3. Behind with an uncommitted change the PR doesn't touch: kept.
echo wip >> "$_t/live/b"
pr 2 a pr2
sync_
check "dirty elsewhere: has the PR" "$(tail -1 "$_t/live/a")" pr2
check "dirty elsewhere: change kept" "$(tail -1 "$_t/live/b")" wip

# 4. Behind with an uncommitted change in a file the PR touches: one
# env notify across runs naming the PR and the file, tree as it was.
pr 3 b pr3
_h="$(head_)"
_n0="$(notified)"
sync_; sync_
check "dirty overlap: HEAD kept" "$(head_)" "$_h"
check "dirty overlap: change kept" "$(tail -1 "$_t/live/b")" wip
check "dirty overlap: one notify" "$(($(notified) - _n0))" 1
check "dirty overlap: env class" "$(tail -1 "$_t/notified" | cut -d'|' -f1)" env
check "dirty overlap: names PR and file" \
  "$(tail -1 "$_t/notified" | grep -c '#3 wait on uncommitted b in')" 1
L checkout -q -- b

# 5. An untracked file the PR adds is in the way too.
echo mine > "$_t/live/c"
pr 4 c theirs
_h="$(head_)"
sync_
check "untracked overlap: HEAD kept" "$(head_)" "$_h"
check "untracked overlap: notifies" "$(tail -1 "$_t/notified" | grep -c ' c in')" 1
rm "$_t/live/c"
sync_
check "unblocked: caught up" "$(head_)" "$(L rev-parse origin/main)"

# 6. Ahead and behind, an unrelated file dirty: rebased with it kept,
# not pushed without --push.
local_ b local1
echo wip >> "$_t/live/a"
pr 5 c pr5
sync_
check "both: has the PR" "$(tail -1 "$_t/live/c")" pr5
check "both: has the local commit" "$(tail -1 "$_t/live/b")" local1
check "both: dirty kept" "$(tail -1 "$_t/live/a")" wip
check "both: on origin/main" \
  "$(L merge-base --is-ancestor origin/main HEAD && echo y)" y
L fetch -q
check "both: not pushed" \
  "$(L merge-base --is-ancestor HEAD origin/main && echo y || echo n)" n
L checkout -q -- a

# 7. --push sends local commits.
sync_ --push
L fetch -q
check "push: origin has them" "$(L rev-parse origin/main)" "$(head_)"

# 8. Conflict: aborted, tree as it was, one notify naming PR and file.
local_ a live-side
pr 6 a main-side
_h="$(head_)"
_n0="$(notified)"
sync_; sync_
check "conflict: HEAD kept" "$(head_)" "$_h"
check "conflict: clean tree" "$(L status --short)" ""
check "conflict: not mid-rebase" \
  "$(test -e "$_t/live/.git/rebase-merge" && echo y || echo n)" n
check "conflict: one notify" "$(($(notified) - _n0))" 1
check "conflict: names PR and file" \
  "$(tail -1 "$_t/notified" | grep -c '#6 conflict .*(a)')" 1
L reset -q --hard origin/main

# 9. Mid-rebase or locked index: hands off.
pr 7 a pr7
_h="$(head_)"
: > "$_t/live/.git/index.lock"
sync_
check "index.lock: untouched" "$(head_)" "$_h"
rm "$_t/live/.git/index.lock"

# 10. Not on main: hands off.
L checkout -q -b other
sync_
check "other branch: untouched" "$(head_)" "$_h"

test "$_fails" = 0 && { echo "all passed"; exit 0; }
cat "$_t/cfg/repo-sync/live/log" 2>/dev/null
echo "$_fails failed"
exit 1
