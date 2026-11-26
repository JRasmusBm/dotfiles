#!/bin/sh
#
# tests/freeze.sh [SCRIPT] — scenarios for bin/freeze's hook and notice
# against throwaway repos whose origins are a work org's or mine, and a
# temp freeze file. SCRIPT defaults to this checkout's bin/freeze.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_freeze="${1:-$_root/bin/freeze}"
_t="$(cd "$(mktemp -d)" && pwd -P)"
trap 'rm -rf "$_t"' EXIT
export FREEZE_FILE="$_t/freeze" HOME="$_t/home"
unset FREEZE_OVERRIDE
_fail=0

_repo() {
  git init -q "$_t/$1"
  git -C "$_t/$1" remote add origin "$2"
}
_repo work git@github.com:work-org/app.git
_repo dots git@github.com:me/dotfiles.git
_repo overlay git@github.com:me/overlay.git
mkdir -p "$HOME/projects" "$_t/plain"
ln -s "$_t/work" "$HOME/projects/work"

_write() {
  printf '%s\n' 'end: 2999-01-01T00:00:00+01:00' 'reason: test' \
    'rules: park it' 'commands: gh[[:space:]]+pr[[:space:]]+merge|tb' \
    > "$FREEZE_FILE"
  test -z "${1:-}" || printf 'repos: %s\n' "$1" >> "$FREEZE_FILE"
}

# scenario NAME want(deny|allow) CWD TOOL COMMAND
scenario() {
  _out="$(jq -nc --arg c "$3" --arg t "$4" --arg x "$5" \
    '{cwd: $c, tool_name: $t, tool_input: {command: $x}}' \
    | sh "$_freeze" hook)"
  case "$_out" in *'"deny"'*) _got=deny ;; *) _got=allow ;; esac
  if [ "$_got" = "$2" ]; then echo "ok   $1"
  else echo "FAIL $1: want $2, got $_got"; _fail=1; fi
}

# notice NAME want(shown|silent) DIR
notice() {
  _out="$(cd "$3" && sh "$_freeze")"
  if [ -n "$_out" ]; then _got=shown; else _got=silent; fi
  if [ "$_got" = "$2" ]; then echo "ok   $1"
  else echo "FAIL $1: want $2, got $_got"; _fail=1; fi
}

_write 'work-org/'
scenario "merge from a work cwd denied" deny "$_t/work" Bash \
  "gh pr merge 12 --squash"
scenario "merge -R a work repo from dotfiles denied" deny "$_t/dots" Bash \
  "gh pr merge 12 -R work-org/app"
scenario "merge by work PR URL denied" deny "$_t/dots" Bash \
  "gh pr merge https://github.com/work-org/app/pull/12"
scenario "cd into a work repo then merge denied" deny "$_t/dots" Bash \
  "cd $_t/work && gh pr merge 12"
scenario "cd ~/ path into a work repo denied" deny "$_t/plain" Bash \
  "cd ~/projects/work && gh pr merge 12"
scenario "quoted cd into a work repo denied" deny "$_t/plain" Bash \
  "cd \"\$HOME/projects/work\" && gh pr merge 12"
scenario "git -C a work repo then tb denied" deny "$_t/dots" Bash \
  "git -C $_t/work fetch; tb"
scenario "merge from dotfiles allowed" allow "$_t/dots" Bash \
  "gh pr merge 12 --squash"
scenario "merge from the overlay allowed" allow "$_t/overlay" Bash \
  "gh pr merge 12 --squash"
scenario "cd into the overlay then merge allowed" allow "$_t/dots" Bash \
  "cd $_t/overlay && gh pr merge 12"
scenario "merge outside any repo allowed" allow "$_t/plain" Bash \
  "gh pr merge 12"
scenario "non-ship command in a work repo allowed" allow "$_t/work" Bash \
  "gh pr ready 12"
scenario "routed MCP tool denied from dotfiles" deny "$_t/dots" \
  mcp__deployer__release ""
scenario "routed MCP tool denied from the overlay" deny "$_t/overlay" \
  mcp__deployer__release ""
notice "notice shown in a work repo" shown "$_t/work"
notice "notice silent in dotfiles" silent "$_t/dots"
notice "notice silent in the overlay" silent "$_t/overlay"

_write
scenario "no repos key: merge from dotfiles denied" deny "$_t/dots" Bash \
  "gh pr merge 12"
notice "no repos key: notice shown in dotfiles" shown "$_t/dots"

exit "$_fail"
