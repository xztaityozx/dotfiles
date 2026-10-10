#!/usr/bin/env bash
# Claude Code statusLine, converted from the zsh prompt (powerline-go,
# modules: aws,ssh,host,docker,cwd,git,jobs,duration,time,exit,newline,user,root
# configured in $ZDOTDIR/powerline.zsh, colors from ~/.config/powerline-go/default.json)
#
# root/exit/duration/jobs are dropped: they reflect real shell/exit-code state
# that has no equivalent in a Claude Code session, and root is the trailing
# prompt symbol which must not be reproduced here. user is dropped too, by
# request. cwd and time segments are dropped too, by request (git segment
# still uses cwd internally to resolve the repo). Session context-window
# usage and claude.ai 5h/7d rate-limit usage (Claude Code-specific, no PS1
# equivalent) are appended at the right end.

input=$(cat)

cwd=$(printf '%s' "$input" | jq -r '.workspace.current_dir // empty')
[ -z "$cwd" ] && cwd=$(pwd)

ESC=$(printf '\033')
RESET="${ESC}[0m"
ARROW=$(printf '\xee\x82\xb0')
prev=""

fg() { printf '%s[38;5;%sm' "$ESC" "$1"; }
bg() { printf '%s[48;5;%sm' "$ESC" "$1"; }

seg() {
  local f="$1" b="$2" t="$3"
  if [ -n "$prev" ]; then
    printf '%s%s%s' "$(fg "$prev")" "$(bg "$b")" "$ARROW"
  fi
  printf '%s%s%s' "$(fg "$f")" "$(bg "$b")" "$t"
  prev="$b"
}

# host segment, only for ssh sessions (mirrors -hostname-only-if-ssh)
if [ -n "$SSH_CONNECTION" ] || [ -n "$SSH_TTY" ]; then
  seg 250 238 " $(hostname -s) "
fi

# git segment (RepoCleanFg/Bg when clean, RepoDirtyFg/Bg when dirty)
if git -C "$cwd" --no-optional-locks rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --quiet --short HEAD 2>/dev/null)
  [ -z "$branch" ] && branch=$(git -C "$cwd" --no-optional-locks rev-parse --short HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
    if [ -z "$(git -C "$cwd" --no-optional-locks status --porcelain 2>/dev/null)" ]; then
      seg 238 112 " $branch "
    else
      seg 249 235 " ${branch}* "
    fi
  fi
fi

# model segment (right end, just before context window usage)
model_name=$(printf '%s' "$input" | jq -r '.model.display_name // empty')
if [ -n "$model_name" ] && [ "$model_name" != "null" ]; then
  seg 255 24 " $model_name "
fi

# reasoning effort segment (right end, next to model), only when present
effort_level=$(printf '%s' "$input" | jq -r '.effort.level // empty')
if [ -n "$effort_level" ] && [ "$effort_level" != "null" ]; then
  seg 255 25 " Effort ${effort_level} "
fi

# context window segment: percentage used / window size (right end)
ctx_pct=$(printf '%s' "$input" | jq -r '.context_window.used_percentage // empty')
ctx_size=$(printf '%s' "$input" | jq -r '.context_window.context_window_size // empty')
if [ -n "$ctx_pct" ] && [ "$ctx_pct" != "null" ]; then
  ctx_pct_r=$(printf '%.0f' "$ctx_pct")
  if [ -n "$ctx_size" ] && [ "$ctx_size" != "null" ] && [ "$ctx_size" -gt 0 ] 2>/dev/null; then
    ctx_size_k=$(awk -v n="$ctx_size" 'BEGIN{printf "%dk", n/1000}')
    seg 235 111 " Ctx ${ctx_pct_r}%/${ctx_size_k} "
  else
    seg 235 111 " Ctx ${ctx_pct_r}% "
  fi
fi

# claude.ai 5-hour rate limit segment (right end), with hh:mm remaining until reset
five_pct=$(printf '%s' "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
if [ -n "$five_pct" ] && [ "$five_pct" != "null" ]; then
  five_pct_r=$(printf '%.0f' "$five_pct")
  five_resets_at=$(printf '%s' "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
  five_remaining=""
  if [ -n "$five_resets_at" ] && [ "$five_resets_at" != "null" ]; then
    five_secs_left=$(( ${five_resets_at%.*} - $(date +%s) ))
    if [ "$five_secs_left" -gt 0 ]; then
      five_remaining=$(printf ' (%02d:%02d)' $((five_secs_left/3600)) $((five_secs_left%3600/60)))
    fi
  fi
  seg 235 178 " 5h ${five_pct_r}%${five_remaining} "
fi

# claude.ai 7-day (weekly) rate limit segment (right end)
week_pct=$(printf '%s' "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
if [ -n "$week_pct" ] && [ "$week_pct" != "null" ]; then
  week_pct_r=$(printf '%.0f' "$week_pct")
  seg 250 60 " 7d ${week_pct_r}% "
fi

# closing cap + reset (no trailing prompt symbol)
printf '%s%s%s' "$(fg "$prev")" "$ARROW" "$RESET"
