#!/bin/sh
#
# tests/docker-guard.sh [SCRIPT] — scenarios for bin/docker-guard's
# one pass against a fake ps whose rows carry the pids of throwaway
# sleeps: a killed row's sleep dies, a spared one lives. SCRIPT
# defaults to this checkout's bin/docker-guard.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_guard="${1:-$_root/bin/docker-guard}"
_t="$(mktemp -d)"
_pids=""
trap 'kill $_pids 2>/dev/null; rm -rf "$_t"' EXIT
export LOCAL_CONFIG="$_t/cfg" DOCKER_GUARD_NOTIFY=true
mkdir -p "$_t/bin"
printf '#!/bin/sh\ncat "%s/rows"\n' "$_t" > "$_t/bin/ps"
chmod +x "$_t/bin/ps"
_fail=0

# scenario NAME want(killed|spared) RSS_KB COMMAND
scenario() {
  sleep 30 &
  _p=$!
  _pids="$_pids $_p"
  printf '%s %s %s\n' "$_p" "$3" "$4" > "$_t/rows"
  PATH="$_t/bin:$PATH" sh "$_guard" once
  if kill -0 "$_p" 2>/dev/null; then _got=spared; else _got=killed; fi
  if [ "$_got" = "$2" ]; then echo "ok   $1"
  else echo "FAIL $1: want $2, got $_got"; _fail=1; fi
}

_big=$((5 * 1024 * 1024))
scenario "sbom killed at any size" killed 1000 \
  "/Users/me/.docker/cli-plugins/docker-scout scout sbom --format x"
scenario "bare docker-scout sbom killed" killed 1000 \
  "docker-scout scout sbom img"
scenario "claude -p mentioning sbom spared" spared 1000 \
  "/Users/me/.local/bin/claude -p 'kill docker-scout scout sbom'"
scenario "big claude mentioning docker-scout spared" spared "$_big" \
  "/Users/me/.local/bin/claude --settings {\"x\":\"docker-scout\"}"
scenario "sh script with sbom args spared" spared 1000 \
  "/bin/sh /tmp/claude-tee -p docker-scout scout sbom"
scenario "big Docker.app process killed" killed "$_big" \
  "/Applications/Docker.app/Contents/MacOS/com.docker.backend"
scenario "small Docker.app process spared" spared 1000 \
  "/Applications/Docker.app/Contents/MacOS/com.docker.backend"
scenario "big VM killed" killed "$_big" \
  "/System/Library/Frameworks/Virtualization.framework/Versions/A/XPCServices/com.apple.Virtualization.VirtualMachine.xpc/Contents/MacOS/com.apple.Virtualization.VirtualMachine"
scenario "big docker-scout (non-sbom) killed" killed "$_big" \
  "/Users/me/.docker/cli-plugins/docker-scout scout cves"
scenario "big nvim with docker-scout in args spared" spared "$_big" \
  "nvim --listen /tmp/nvim-docker-scout-sbom"
exit "$_fail"
