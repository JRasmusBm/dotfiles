#!/usr/bin/env bash
# PreToolUse hook for Read: a whole-file read of a big file re-enters the
# context on every later turn. Doesn't block; tells the agent to search or
# read a range next time.
input=$(cat)
read -r path offset limit < <(printf '%s' "$input" \
  | jq -r '.tool_input | [.file_path // "", .offset // "", .limit // ""] | @tsv')
[ -n "$path" ] && [ -z "$offset$limit" ] && [ -f "$path" ] || exit 0
case "$path" in
  *.png | *.jpg | *.jpeg | *.gif | *.webp | *.pdf | *.ipynb) exit 0 ;;
esac
bytes=$(wc -c <"$path" | tr -d ' ')
[ "$bytes" -gt "${READ_NUDGE_BYTES:-20000}" ] || exit 0
jq -n --arg b "$bytes" '{hookSpecificOutput: {hookEventName: "PreToolUse",
  additionalContext: ("This file is \($b) bytes and now sits in your context for every later turn. Next time Grep for the symbol or Read with offset/limit; whole-file only when you need all of it.")}}'
