#!/bin/sh
#
# tests/chrome-clone-sweep.sh [SCRIPT] — scenarios for the profile
# half of bin/chrome-clone-sweep against a fake temp dir: which
# chrome-devtools-mcp.* dirs it deletes. LOCAL_CONFIG is a temp dir.
# SCRIPT defaults to this checkout's bin/chrome-clone-sweep.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_bin="${1:-$_root/bin/chrome-clone-sweep}"
_t="$(mktemp -d)"
_pids=
trap 'kill $_pids 2>/dev/null; rm -rf "$_t"' EXIT
export LOCAL_CONFIG="$_t/cfg" CHROME_SWEEP_TMP="$_t/T/"
mkdir -p "$LOCAL_CONFIG/memlog" "$_t/T"
_fail=0

_ok() { echo "ok   $1"; }
_no() { echo "FAIL $1"; _fail=1; }
_old() {
  mkdir -p "$_t/T/$1/Default"
  : > "$_t/T/$1/Default/Cookies"
  touch -t 202601010000 "$_t/T/$1"
}

_old chrome-devtools-mcp.orphan
_old chrome-devtools-mcp.argsLive
_old chrome-devtools-mcp.openLive
_old other.dir
mkdir -p "$_t/T/chrome-devtools-mcp.young"
sh -c 'sleep 60; :' "$_t/T/chrome-devtools-mcp.argsLive" &
_pids="$_pids $!"
sleep 60 3<"$_t/T/chrome-devtools-mcp.openLive/Default/Cookies" &
_pids="$_pids $!"
sleep 1

"$_bin" -n | grep -q orphan \
  && test -d "$_t/T/chrome-devtools-mcp.orphan" \
  && _ok "-n lists the orphan, deletes nothing" \
  || _no "-n output or deletion"

"$_bin"
test ! -e "$_t/T/chrome-devtools-mcp.orphan" \
  && grep -q 'orphan profile' "$LOCAL_CONFIG/memlog/$(date +%F).log" \
  && _ok "old dir no process uses: deleted and logged" \
  || _no "orphan kept or not logged"
test -d "$_t/T/chrome-devtools-mcp.argsLive" \
  && _ok "dir named in a live process's args: kept" \
  || _no "deleted a dir a process names"
test -d "$_t/T/chrome-devtools-mcp.openLive" \
  && _ok "dir a process holds open: kept" \
  || _no "deleted a dir held open"
test -d "$_t/T/chrome-devtools-mcp.young" \
  && _ok "dir younger than 2h: kept" \
  || _no "deleted a young dir"
test -d "$_t/T/other.dir" \
  && _ok "other temp dirs: kept" \
  || _no "deleted an unrelated dir"

exit "$_fail"
