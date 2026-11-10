#!/bin/sh
#
# tests/pr-gate.sh [SCRIPT] — scenarios for bin/pr-gate's hook against
# throwaway repos, a temp board (LOCAL_CONFIG) and a fake gh. SCRIPT
# defaults to this checkout's bin/pr-gate.

set -u
_root="$(cd "$(dirname "$0")/.." && pwd)"
_gate="${1:-$_root/bin/pr-gate}"
_t="$(cd "$(mktemp -d)" && pwd -P)"
trap 'rm -rf "$_t"' EXIT
export FAKE="$_t/fake" LOCAL_CONFIG="$_t/cfg"
mkdir -p "$FAKE/bin" "$LOCAL_CONFIG/worktrees"

cat > "$FAKE/bin/gh" <<'X'
#!/bin/sh
test ! -f "$FAKE/ghfail" || exit 1
test "$1 $2" = "pr list" && cat "$FAKE/prs"
X
chmod +x "$FAKE/bin/gh"
export PATH="$FAKE/bin:$PATH"
echo '[]' > "$FAKE/prs"

_repo() {
  git init -q -b main "$_t/$1"
  git -C "$_t/$1" commit -q --no-verify --allow-empty -m init
}
_wt() {
  git -C "$_t/$1" worktree add -q -b "$3" "$_t/$1/$2"
}

_repo managed
mkdir "$_t/managed/.jrb" && : > "$_t/managed/.jrb/wt-hook"
_wt managed .worktrees/on feat/jrb/abc-1-on
_wt managed .worktrees/off feat/jrb/abc-2-off
_wt managed .worktrees/split abc-1-split
_wt managed .worktrees/stack feat/jrb/abc-3-stack
_wt managed .worktrees/free fix/jrb/no-ticket-here
_wt managed .claude/worktrees/agent-a1 worktree-agent-a1
printf '# IN PROGRESS\nfeat/jrb/abc-1-on\nabc-1-split\n\n# TEAM REVIEW\n%s\n' \
  'feat/jrb/abc-3-stack' > "$LOCAL_CONFIG/worktrees/managed"
echo fix/jrb/no-ticket-here >> "$LOCAL_CONFIG/worktrees/managed"

_repo tooling
_wt tooling .worktrees/off feat/jrb/abc-9-tool
_wt tooling .claude/worktrees/agent-b2 worktree-agent-b2
printf '# IN PROGRESS\n\n' > "$LOCAL_CONFIG/worktrees/tooling"

_repo plain
_wt plain .claude/worktrees/agent-c3 worktree-agent-c3

_pass=0 _fail=0
_case() {
  _want="$1" _dir="$2" _cmd="$3"
  _out="$(jq -nc --arg c "$_cmd" --arg d "$_t/$_dir" \
    '{cwd: $d, tool_input: {command: $c}}' | "$_gate" hook)"
  case "$_out" in
    *'"deny"'*) _got=deny ;;
    '') _got=allow ;;
    *) _got="junk: $_out" ;;
  esac
  if test "$_got" = "$_want"; then
    _pass=$((_pass + 1))
    printf 'ok    %-5s %-28s %s\n' "$_want" "$_dir" "$_cmd"
  else
    _fail=$((_fail + 1))
    printf 'FAIL  want %s got %s: %s: %s\n' "$_want" "$_got" "$_dir" "$_cmd"
  fi
  _last="$_out"
}
_says() {
  case "$_last" in
    *"$1"*) _pass=$((_pass + 1)); echo "ok    message has: $1" ;;
    *) _fail=$((_fail + 1)); echo "FAIL  message lacks: $1: $_last" ;;
  esac
}

echo '# subagent checkout: refused, drafts too, compound too'
_case deny managed/.claude/worktrees/agent-a1 'gh pr create --fill'
_says 'wt fix|feat <ticket url>'
_case deny managed/.claude/worktrees/agent-a1 'gh pr create --draft --fill'
_case deny managed/.claude/worktrees/agent-a1 \
  'git push -u origin HEAD && gh pr create --draft --title "x" --body "y"'
_case deny managed 'cd .claude/worktrees/agent-a1 && gh pr create --fill'
_case deny managed "cd '$_t/managed/.claude/worktrees/agent-a1'; gh pr create"
_case deny tooling/.claude/worktrees/agent-b2 'gh pr create --fill'
_case deny plain/.claude/worktrees/agent-c3 'gh pr create --fill'
_case deny managed/.claude/worktrees/agent-a1 "sh -c 'gh pr create --fill'"

echo '# off the board of a repo with a release hook: refused'
_case deny managed/.worktrees/off 'gh pr create --draft --fill'
_case deny managed 'gh pr create --fill'
_case deny managed/.worktrees/on 'gh pr create --head feat/jrb/abc-2-off'

echo '# on the board: allowed, any section, any base'
_case allow managed/.worktrees/on 'gh pr create --fill'
_case allow managed/.worktrees/on 'gh pr create --draft --fill'
_case allow managed/.worktrees/stack 'gh pr create --base feat/jrb/abc-1-on'
_case allow managed/.worktrees/free 'gh pr create --fill'
_case allow managed/.worktrees/off 'gh pr create -H me:feat/jrb/abc-1-on'

echo '# tooling repo (no release hook) and unmanaged repo: allowed'
_case allow tooling 'gh pr create --fill'
_case allow tooling/.worktrees/off 'gh pr create --fill'
_case allow plain 'gh pr create --fill'

echo '# not a PR create: allowed'
_case allow managed/.claude/worktrees/agent-a1 'gh pr view 12'
_case allow managed/.claude/worktrees/agent-a1 'gh pr list --state open'
_case allow managed/.claude/worktrees/agent-a1 \
  'git commit -m "refuse gh pr create from agents"'
_case allow managed/.claude/worktrees/agent-a1 "git commit -F - <<'EOF'
pr-gate: gh pr create needs a board row
EOF"
_case allow "" 'gh pr create --fill'

echo '# ticket id reused by another open PR: refused, from any checkout'
cat > "$FAKE/prs" <<'X'
[{"headRefName": "feat/jrb/abc-1-on", "url": "https://x/pull/1"},
 {"headRefName": "fix/jrb/abc-10-other", "url": "https://x/pull/10"}]
X
_case deny managed/.worktrees/split 'gh pr create --draft --fill'
_says 'ABC-1 already has an open PR from another branch: https://x/pull/1'
_case deny tooling/.worktrees/off 'gh pr create -H feat/jrb/ABC-1-again'
_case allow managed/.worktrees/on 'gh pr create --fill'
_case allow managed/.worktrees/stack 'gh pr create --fill'
_case allow managed/.worktrees/free 'gh pr create --fill'
echo '[{"headRefName": "feat/jrb/abc-4-x-abc-1-y", "url": "u"}]' \
  > "$FAKE/prs"
_case allow managed/.worktrees/split 'gh pr create --fill'

echo '# gh fails: the id check is skipped, the board check stands'
: > "$FAKE/ghfail"
_case allow managed/.worktrees/split 'gh pr create --fill'
_case deny managed/.worktrees/off 'gh pr create --fill'
rm "$FAKE/ghfail"

echo "pass $_pass, fail $_fail"
test "$_fail" -eq 0
