#!/bin/sh
#
# tests/lin-gql-retry.sh [LIN] — `lin state` checks Linear's reply
# before parsing it (RAS-88): a reply that isn't JSON (an error page)
# is reported with its HTTP status and the start of the body, then
# retried once; a GraphQL error is reported and not retried. curl is
# a fake that plays back one canned reply per call from $_t/replies.
# LIN defaults to this checkout's bin/lin.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_lin="${1:-$_root/bin/lin}"
_t="$(mktemp -d /tmp/tlg.XXXX)"
trap 'rm -rf "$_t"' EXIT
mkdir -p "$_t/bin" "$_t/replies"
cat > "$_t/bin/curl" <<X
#!/bin/sh
cat > /dev/null
_n="\$(ls "$_t/replies" | head -1)"
echo call >> "$_t/calls"
test -n "\$_n" || { printf '\n000'; exit 7; }
cat "$_t/replies/\$_n"
rm "$_t/replies/\$_n"
X
chmod +x "$_t/bin/curl"
export PATH="$_t/bin:$PATH" LINEAR_API_KEY=k LIN_RETRY_DELAY=0

_fail=0
ok() { echo "ok   $1"; }
no() { echo "FAIL $1: $2"; _fail=1; }

_issue='{"data":{"issue":{"id":"u1","state":{"name":"Todo"},
"team":{"states":{"nodes":[{"id":"s1","name":"Todo"},
{"id":"s2","name":"Done"}]}}}}}'
_ok='{"data":{"issueUpdate":{"success":true}}}'
_page='<html>
<body>502 Bad Gateway</body></html>'

# Replies: one file per call, played in name order.
_play() {
  rm -f "$_t/replies/"* "$_t/calls"
  _i=0
  for _r in "$@"; do
    _i=$((_i + 1))
    printf '%s' "$_r" > "$_t/replies/$_i"
  done
}
_run() { "$_lin" state Done ABC-1 > "$_t/out" 2> "$_t/err"; }
_calls() { wc -l < "$_t/calls" | tr -d ' '; }

_play "$_issue
200" "$_ok
200"
if _run; then ok 'happy path'; else no 'happy path' "$(cat "$_t/err")"; fi
grep -q 'ABC-1: Todo → Done' "$_t/err" \
  && ok 'happy path says the move' || no 'move msg' "$(cat "$_t/err")"

_play "$_page
502" "$_issue
200" "$_ok
200"
if _run; then ok 'error page then JSON: retried, moved'
else no 'retry' "$(cat "$_t/err")"; fi
grep -q 'HTTP 502, not JSON: <html> <body>502 Bad Gateway' "$_t/err" \
  && ok 'says status and body start' || no 'why' "$(cat "$_t/err")"
grep -q 'parse error' "$_t/err" \
  && no 'no jq noise' "$(cat "$_t/err")" || ok 'no jq parse error'
test "$(_calls)" = 3 && ok '3 calls' || no 'calls' "$(_calls)"

_play "$_page
502" "$_page
503"
if _run; then no 'two error pages fail' "exit 0"
else ok 'two error pages: fails'; fi
test "$(_calls)" = 2 && ok 'retries only once' || no 'calls' "$(_calls)"
grep -q 'HTTP 503' "$_t/err" \
  && ok 'says the second status' || no 'second' "$(cat "$_t/err")"

_play
if _run; then no 'network failure fails' "exit 0"
else ok 'network failure: fails'; fi
grep -q 'HTTP 000' "$_t/err" \
  && ok 'network failure says 000' || no '000' "$(cat "$_t/err")"

_play '{"errors":[{"message":"Entity not found"}]}
400'
if _run; then no 'graphql error fails' "exit 0"
else ok 'graphql error: fails'; fi
grep -q 'Entity not found' "$_t/err" \
  && ok 'says graphql message' || no 'gql msg' "$(cat "$_t/err")"
test "$(_calls)" = 1 && ok 'graphql error not retried' \
  || no 'calls' "$(_calls)"

exit "$_fail"
