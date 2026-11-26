#!/bin/sh
#
# tests/chrome-devtools-mcp-session.sh [BIN_DIR] — profile lifecycle of
# bin/chrome-devtools-mcp-session + chrome-devtools-mcp-proxy against a
# fake chrome-devtools-mcp server: the profile is seeded only on the
# first browser call and deleted when the client goes, even when the
# session shell is SIGKILLed. HOME and TMPDIR are temp dirs.
# BIN_DIR defaults to this checkout's bin/.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_bins="${1:-$_root/bin}"
_py="$(command -v python3)"
_t="$(mktemp -d)"
trap 'rm -rf "$_t"' EXIT
_fail=0

_ok() { echo "ok   $1"; }
_no() { echo "FAIL $1"; _fail=1; }

_ver=$(sed -n 's/^VERSION = "\(.*\)"/\1/p' "$_bins/chrome-devtools-mcp-proxy")
mkdir -p "$_t/bin" "$_t/pkg/a/b/c" "$_t/tmp" \
  "$_t/home/.cache/chrome-devtools-mcp/chrome-profile/Default/Sessions"
_seed="$_t/home/.cache/chrome-devtools-mcp/chrome-profile"
echo '{"browser": {"window_placement": 1, "x": 2}}' \
  > "$_seed/Default/Preferences"
ln -s nowhere "$_seed/SingletonLock"
echo '{"initialize": {}, "tools/list": {}}' \
  > "$_t/home/.cache/chrome-devtools-mcp/proxy-$_ver.json"
printf '{"version": "%s"}\n' "$_ver" > "$_t/pkg/package.json"
cat > "$_t/pkg/a/b/c/server" <<EOF
#!$_py
import json, sys
for line in sys.stdin:
    m = json.loads(line)
    if "id" in m:
        print(json.dumps({"jsonrpc": "2.0", "id": m["id"], "result": {}}),
              flush=True)
EOF
chmod +x "$_t/pkg/a/b/c/server"
ln -s "$_t/pkg/a/b/c/server" "$_t/bin/chrome-devtools-mcp"
ln -s "$_py" "$_t/bin/python3"
export HOME="$_t/home" TMPDIR="$_t/tmp" PATH="$_t/bin:/usr/bin:/bin"
unset TMUX_PANE

_req() {
  printf '{"jsonrpc":"2.0","id":%s,"method":"%s","params":{}}\n' "$1" "$2"
}
_profile() { ls -d "$_t/tmp"/chrome-devtools-mcp.* 2>/dev/null; }
_session() {
  mkfifo "$_t/in"
  "$_bins/chrome-devtools-mcp-session" < "$_t/in" > "$_t/out" 2>/dev/null &
  _sh=$!
  exec 4>"$_t/in"
  rm "$_t/in"
  _req 1 initialize >&4
}
_wait_for() {
  _i=0
  while ! eval "$1" && test $_i -lt 100; do sleep 0.1; _i=$((_i + 1)); done
  eval "$1"
}

_session
_wait_for 'grep -q "\"id\": 1" "$_t/out"'
_p=$(_profile)
test -n "$_p" && test -z "$(ls -A "$_p")" \
  && _ok "no browser call: profile dir empty" \
  || _no "profile seeded before any browser call"
exec 4>&-
_wait_for 'test -z "$(_profile)"' \
  && _ok "client gone: profile dir deleted" \
  || _no "profile left after client exit"
wait $_sh 2>/dev/null

_session
_req 2 tools/call >&4
_wait_for 'grep -q "\"id\": 2" "$_t/out"'
_p=$(_profile)
test -d "$_p/Default" && test ! -e "$_p/Default/Sessions" \
  && test ! -L "$_p/SingletonLock" \
  && ! grep -q window_placement "$_p/Default/Preferences" \
  && _ok "first browser call: seed copied, minus locks/sessions/placement" \
  || _no "profile not seeded right"
kill -9 $_sh
exec 4>&-
_wait_for 'test -z "$(_profile)"' \
  && _ok "session shell SIGKILLed: proxy still deletes the profile" \
  || _no "profile leaked after SIGKILL of the session shell"

exit "$_fail"
