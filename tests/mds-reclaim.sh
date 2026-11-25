#!/bin/sh
#
# tests/mds-reclaim.sh [SCRIPT] — scenarios for bin/mds-reclaim
# against a fake memlog and a fake kill command. Nothing real is
# touched: LOCAL_CONFIG is a temp dir, notify is a no-op on PATH.
# SCRIPT defaults to this checkout's bin/mds-reclaim.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_bin="${1:-$_root/bin/mds-reclaim}"
_t="$(mktemp -d)"
trap 'rm -rf "$_t"' EXIT
export LOCAL_CONFIG="$_t/cfg" MDS_RECLAIM_KILL="$_t/kill"
export PATH="$_t/bin:$PATH"
mkdir -p "$_t/bin" "$LOCAL_CONFIG/memlog"
printf '#!/bin/sh\n' > "$_t/bin/notify"; chmod +x "$_t/bin/notify"
_log="$LOCAL_CONFIG/memlog/$(date +%F).log"
_mds=/System/Library/Frameworks/CoreServices.framework/Versions/A
_mds="$_mds/Frameworks/Metadata.framework/Versions/A/Support/mds"
_fail=0

_ok() { echo "ok   $1"; }
_no() { echo "FAIL $1"; _fail=1; }
_calls() { cat "$_t/calls" 2>/dev/null | wc -l | tr -d ' '; }
_killer() {
  printf '#!/bin/sh\necho x >> %s\nexit %s\n' "$_t/calls" "$1" \
    > "$_t/kill"
  chmod +x "$_t/kill"
}
# Snapshot with mds at $1 MB, after an older one where it was huge.
_snap() {
  printf '=== 2026-11-25 10:00:00 pressure=1\n9000 365 1:00 - %s\n' \
    "$_mds" > "$_log"
  printf '=== 2026-11-25 10:01:00 pressure=1\n%s 365 1:01 - %s\n' \
    "$1" "$_mds" >> "$_log"
  printf '8000 366 1:01 - /usr/bin/mds_stores\n' >> "$_log"
}

_killer 0; _snap 3000; "$_bin"
test "$(_calls)" = 0 \
  && _ok "latest mds under 6 GB (older huge, mds_stores huge): kept" \
  || _no "killed on a stale snapshot or mds_stores"

_snap 31744; "$_bin"
test "$(_calls)" = 1 && grep -q 'killed mds 31744MB' "$_log" \
  && _ok "mds over 6 GB: killed and logged" \
  || _no "big mds not killed/logged"

: > "$_t/calls"; _killer 1; _snap 31744
"$_bin"; "$_bin"; "$_bin"
test "$(_calls)" = 3 && test "$(grep -c failed "$_log")" = 1 \
  && _ok "no sudo rule: retried each run, failure logged once" \
  || _no "failure logged $(grep -c failed "$_log") times"

_killer 0; "$_bin"
grep -q 'killed mds' "$_log" \
  && test ! -f "$LOCAL_CONFIG/memlog/mds-reclaim.nosudo" \
  && _ok "rule installed later: kill works, flag cleared" \
  || _no "recovery after sudo rule"

exit "$_fail"
