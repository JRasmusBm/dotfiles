#!/bin/sh
# Claude Code status line — distributes parts evenly across width.
# Input: JSON via stdin.

DIM='\033[2m'
RESET='\033[0m'
GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'
MAGENTA='\033[35m'
BLUE='\033[34m'

input=$(cat)

# ── helpers ──────────────────────────────────────────────

threshold_color() {
  percent=$(printf '%.0f' "$1")
  if   [ "$percent" -ge 80 ]; then printf '%s' "$RED"
  elif [ "$percent" -ge 50 ]; then printf '%s' "$YELLOW"
  else                              printf '%s' "$GREEN"
  fi
}

progress_bar() {
  percent=$(printf '%.0f' "$1")
  filled_blocks=$(( percent * 10 / 100 ))
  empty_blocks=$(( 10 - filled_blocks ))
  block_idx=0
  while [ "$block_idx" -lt "$filled_blocks" ]; do
    printf '█'
    block_idx=$(( block_idx + 1 ))
  done
  block_idx=0
  while [ "$block_idx" -lt "$empty_blocks" ]; do
    printf '░'
    block_idx=$(( block_idx + 1 ))
  done
}

# Visible char count: strips ANSI escapes, counts unicode codepoints.
visible_length() {
  printf '%s' "$1" \
    | sed 's/\\033\[[0-9;]*m//g' \
    | perl -CS -E 'local $/; $_=<STDIN>; chomp; print length'
}

# ── extract fields ────────────────────────────────────────

model_slug=$(echo      "$input" | jq -r '.model.id // .model.slug // .model.display_name // ""' | sed -e 's/^claude-//' -e 's/\[[^]]*\]$//')
context_pct=$(echo     "$input" | jq -r '.context_window.used_percentage // empty')
five_hour_pct=$(echo   "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
seven_day_pct=$(echo   "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
transcript_path=$(echo "$input" | jq -r '.transcript_path // empty')
term_width=$(echo      "$input" | jq -r '.terminal.width // .terminal.cols // empty')
if [ -z "$term_width" ] && [ -n "$TMUX" ]; then
  term_width=$(tmux display -p -t "${TMUX_PANE:-}" '#{pane_width}' 2>/dev/null)
fi
[ -z "$term_width" ] && term_width=${COLUMNS:-$(tput cols 2>/dev/null)}
[ -z "$term_width" ] && term_width=80

# ── build parts ──────────────────────────────────────────

part_count=0
add_part() {
  eval "part_${part_count}=\"\$1\""
  part_count=$(( part_count + 1 ))
}

if [ -n "$model_slug" ]; then
  add_part "${MAGENTA}${model_slug}${RESET}"
fi

if [ -n "$context_pct" ]; then
  rounded=$(printf '%.0f' "$context_pct")
  color=$(threshold_color "$context_pct")
  blocks=$(progress_bar "$context_pct")
  add_part "${color}${blocks} ${rounded}%${RESET}"
fi

if [ -n "$five_hour_pct" ]; then
  rounded=$(printf '%.0f' "$five_hour_pct")
  color=$(threshold_color "$five_hour_pct")
  add_part "${color}5h:${rounded}%${RESET}"
fi

if [ -n "$seven_day_pct" ]; then
  rounded=$(printf '%.0f' "$seven_day_pct")
  color=$(threshold_color "$seven_day_pct")
  add_part "${color}7d:${rounded}%${RESET}"
fi

if [ -n "$transcript_path" ] && [ -f "$transcript_path" ]; then
  birth_epoch=$(stat -f %B "$transcript_path" 2>/dev/null)
  if [ -z "$birth_epoch" ] || [ "$birth_epoch" = "0" ]; then
    birth_epoch=$(stat -f %c "$transcript_path" 2>/dev/null)
  fi
  if [ -n "$birth_epoch" ]; then
    now_epoch=$(date +%s)
    elapsed_sec=$(( now_epoch - birth_epoch ))
    total_minutes=$(( elapsed_sec / 60 ))
    elapsed_hours=$(( total_minutes / 60 ))
    elapsed_minutes=$(( total_minutes % 60 ))
    if [ "$elapsed_hours" -gt 0 ]; then
      duration=$(printf '%dh %02dm' "$elapsed_hours" "$elapsed_minutes")
    else
      duration="${total_minutes}m"
    fi
    add_part "${BLUE}${duration}${RESET}"
  fi
fi

# ── distribute padding ────────────────────────────────────

if [ "$part_count" = "0" ]; then
  exit 0
fi

total_visible=0
part_idx=0
while [ "$part_idx" -lt "$part_count" ]; do
  eval "current_part=\"\$part_${part_idx}\""
  part_visible=$(visible_length "$current_part")
  total_visible=$(( total_visible + part_visible ))
  part_idx=$(( part_idx + 1 ))
done

line=""
gap_count=$(( part_count - 1 ))
gap_width=5
pre_sep=$(( (gap_width - 1) / 2 ))
post_sep=$(( gap_width - 1 - pre_sep ))
left_spaces=$(printf  '%*s' "$pre_sep"  '')
right_spaces=$(printf '%*s' "$post_sep" '')
separator="${left_spaces}${DIM}│${RESET}${right_spaces}"

part_idx=0
while [ "$part_idx" -lt "$part_count" ]; do
  eval "current_part=\"\$part_${part_idx}\""
  line="${line}${current_part}"
  if [ "$part_idx" -lt "$gap_count" ]; then
    line="${line}${separator}"
  fi
  part_idx=$(( part_idx + 1 ))
done

content_width=$(( total_visible + gap_count * gap_width ))
leading_pad=$(( (term_width - content_width) / 2 ))
[ "$leading_pad" -lt 0 ] && leading_pad=0

# Claude Code trims leading whitespace (incl. NBSP). Use Braille blank
# (U+2800) which is non-whitespace and renders one column wide.
braille_blank=$(printf '\xe2\xa0\x80')
leading_spaces=""
pad_idx=0
while [ "$pad_idx" -lt "$leading_pad" ]; do
  leading_spaces="${leading_spaces}${braille_blank}"
  pad_idx=$(( pad_idx + 1 ))
done

printf '%b\n' "${leading_spaces}${line}"
# Pad with a blank line below for breathing room. Use Braille blank
# so Claude Code doesn't trim the trailing empty line.
printf '%b\n' "${braille_blank}"
