#!/bin/sh
#
# tests/tmux-live-socket.sh — RAS-41's done-when, on this machine's
# real setup: neither a test's own TMUX_TMPDIR (through the shim, from a
# pane) nor the raw binary with a missing TMUX_TMPDIR (tmux's /tmp
# fallback) reaches the live server. Read-only: `display` never starts
# or stops a server. Fails while the live server is still in /tmp.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_realtmux=/opt/homebrew/bin/tmux
_fail=0
_ok() { echo "ok   $1"; }
_no() { echo "FAIL $1: $2"; _fail=1; }

_live="$("$_root/shims/tmux" display -p '#{pid} #{socket_path}' 2>/dev/null)"
test -n "$_live" || { echo "FAIL no live server to compare with"; exit 1; }
_lpid="${_live%% *}"
echo "live server: $_live"

_f="$(mktemp -d)"
trap 'rm -rf "$_f"' EXIT
_got="$(TMUX_TMPDIR="$_f" "$_root/shims/tmux" display -p '#{socket_path}' 2>&1)"
case "$_got" in
  *"$(cd "$_f" && pwd -P)"/*|*"$_f"/*)
    _ok "a fresh TMUX_TMPDIR answers from its own dir" ;;
  *) _no "fresh TMUX_TMPDIR" "answered '$_got'" ;;
esac

_got="$(env -u TMUX -u TMUX_PANE TMUX_TMPDIR=/nonexistent "$_realtmux" \
  -L default display -p '#{pid}' 2>&1)"
test "$_got" != "$_lpid" \
  && _ok "raw tmux, missing TMUX_TMPDIR, misses the live server ($_got)" \
  || _no "raw fallback" "reached the live server, pid $_got"

_got="$(env -u TMUX -u TMUX_PANE -u TMUX_TMPDIR "$_realtmux" \
  -L default display -p '#{pid}' 2>&1)"
test "$_got" != "$_lpid" \
  && _ok "raw tmux, no TMUX_TMPDIR at all, misses the live server ($_got)" \
  || _no "raw default" "reached the live server, pid $_got"
exit "$_fail"
