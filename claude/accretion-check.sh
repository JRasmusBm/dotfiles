#!/usr/bin/env bash
# Stop hook: flag files this branch grows by piling on rather than rewriting.
git rev-parse --git-dir >/dev/null 2>&1 || exit 0

base=""
for candidate in \
  "$(git symbolic-ref -q --short refs/remotes/origin/HEAD 2>/dev/null)" \
  origin/dev origin/main origin/master; do
  [ -n "$candidate" ] || continue
  base=$(git merge-base "$candidate" HEAD 2>/dev/null) && break
done
[ -n "$base" ] || base=$(git rev-parse @{u} 2>/dev/null) || exit 0
base=${ACCRETION_BASE:-$base}
head=${ACCRETION_HEAD:-}

flag_file() {
  local add=$1 del=$2 path=$3 headings
  [[ "$add" =~ ^[0-9]+$ ]] || return 0
  git cat-file -e "$base:$path" 2>/dev/null || return 0

  if [[ "$path" == *.md || "$path" == *.mdx || "$path" == *.txt || "$path" == *.rst ]]; then
    local diff gained lost
    diff=$(git diff "$base" $head -- "$path")
    gained=$(printf '%s\n' "$diff" | grep -c '^+#\{1,3\} ')
    lost=$(printf '%s\n' "$diff" | grep -c '^-#\{1,3\} ')
    if [ "$gained" -gt "$lost" ] && [ "$add" -gt "$del" ]; then
      printf '%s gained %s section(s); ' "$path" "$((gained - lost))"
      return 0
    fi
    [ "$add" -gt $((del + 8)) ] && printf '%s +%s/-%s; ' "$path" "$add" "$del"
    return 0
  fi
  [ "$add" -gt $((6 * del + 80)) ] && printf '%s +%s/-%s; ' "$path" "$add" "$del"
  return 0
}

flagged=""
while read -r add del path; do
  flagged+=$(flag_file "$add" "$del" "$path")
done < <(git diff --numstat "$base" $head 2>/dev/null)

[ -n "$flagged" ] || exit 0
printf '{"systemMessage":"Accretion — %sWhat did these replace?"}\n' "$flagged"
