#!/bin/sh
#
# tests/cache-why.sh [BIN] — cache-why names each mid-session cache
# rewrite by cause (compaction, process restart, a tool added, server
# miss), counts an API response once however many rows repeat its
# usage, and skips a session's first request. A fixture transcript
# under a temp HOME. BIN defaults to this checkout's bin/.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_bin="${1:-$_root/bin}"
_t="$(mktemp -d /tmp/tcw.XXXX)"
trap 'rm -rf "$_t"' EXIT
export HOME="$_t"
_d="$HOME/.claude/projects/-x"
mkdir -p "$_d"

_fail=0
ok() { echo "ok   $1"; }
no() { echo "FAIL $1: $2"; _fail=1; }
has() { printf '%s\n' "$2" | grep -qF -- "$3" && ok "$1" || no "$1" "$2"; }

now=$(date -u +%s)
at() { date -u -r $((now - 3600 + $1)) +%Y-%m-%dT%H:%M:%S.000Z; }
shape() { printf '{"type":"api-request-shape","shapeHash":"%s","shape":{"system":[{"text":"s"}],"tools":[%s]}}\n' "$1" "$2"; }
req() { printf '{"type":"api-request","id":"%s","shapeHash":"%s","base":%s,"keep":%s,"tail":["a","b"]}\n' "$1" "$2" "$3" "$4"; }
asst() { printf '{"type":"assistant","timestamp":"%s","message":{"id":"%s","usage":{"cache_creation_input_tokens":%s}}}\n' "$(at "$1")" "$2" "$3"; }

{
  shape h1 '{"name":"Read"}'
  shape h2 '{"name":"Read"},{"name":"mcp__foo__get"}'
  req r1 h1 null 0;      asst 0 m1 90000      # first request: skipped
  req r2 h1 '"r1"' 2;    asst 10 m2 1000; asst 10 m2 1000
  printf '{"type":"system","subtype":"compact_boundary","compactMetadata":{"trigger":"auto"}}\n'
  req r3 h1 null 0;      asst 20 m3 70000     # compaction
  req r4 h1 null 0;      asst 30 m4 60000     # restart, no compact
  req r5 h2 '"r4"' 2;    asst 40 m5 50000; asst 40 m5 50000
  req r6 h2 '"r5"' 4;    asst 50 m6 45000     # prefix intact
  req r7 h2 '"r6"' 6;    asst 900 m7 80000    # after a 14 min gap
} > "$_d/s.jsonl"

out="$("$_bin/cache-why" --since 1d)"
has "compaction"         "$out" "0.1M     1  main: compaction (auto)"
has "process restart"    "$out" "0.1M     1  main: process restart"
has "tool added"         "$out" "main: system/tools changed: +mcp:foo"
has "server miss"        "$out" "main: server miss"
has "gap and first skip" "$out" "4 requests"
# 70k+60k+50k+45k; m5 counted twice would make it 0.3M
has "one row per reply"  "$out" "0.2M raw, 4 requests"

exit $_fail
