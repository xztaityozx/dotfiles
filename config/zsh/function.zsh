#!/usr/bin/zsh

# ggc user/repo
# ghq get hoge/fuga && cd $(ghq root)/github.com/hoge/fuga
function ggc() {
  local repo="$1"
  ghq get $repo &&
    cd $(ghq root)/github.com/$repo
}

function hub-remote-set-ssh() {
  local repo="$(basename $(pwd))"
  hub remote set-url origin git@github.com:xztaityozx/$repo
}

# output information to stdout
# usage: logger.info [text]
function logger.info() {
  echo "\033[34m[info] [$(date)]\033[39m $*"
}

# output warning to stdout
# usage: logger.warn [text]
function logger.warn() {
  echo "\033[33m[warn] [$(date)]\033[39m $*"
}

# copy text to clipboard
# usage:
#   - yy [text] -> copy [text] to clipboard
#   - [command] | yy -> copy [command]'s output to clipboard
#   - yy -> copy last command
function yy() {
  local text="${*}"
  [ -p /dev/fd/0 ] && text=$(cat -)
  [ "$text" = "" ] && text="$(history | tail -n1 |cut -d' ' -f4-)"

  # wsl
  type clip.exe 2>&1 > /dev/null && echo -n "$text" | clip.exe && return 0
  # xclip
  type xclip 2>&1 > /dev/null && echo -n "$text" | xclip -selection c && return 0
  # xsel 
  type xsel 2>&1 > /dev/null && echo -n "$text" | xsel -b && return 0
  # pbcopy
  type pbcopy 2>&1 > /dev/null && echo -n "$text" | pbcopy && return 0

  logger.warn "clip.exe, xclip, pbcopy or xsel not found"
}

# reconfigure
function rescale() {
  [ "$1" = "HDMI" ] && gsettings set org.gnome.desktop.interface scaling-factor 2 &&
  xrandr --output HDMI1 --scale 1x1 &&
  xrandr --output HDMI1 --scale 1.2x1.2 &&
  xrandr --output HDMI1 --panning 2304x1440 && exit

  gsettings set org.gnome.desktop.interface scaling-factor 2
  xrandr --output DSI1 --scale 1x1
  xrandr --output DSI1 --scale 1.2x1.2
  xrandr --output DSI1 --panning 2304x1536
}

# awk for csv
function cawk() {
  awk -F, "$@"
}

function ohiru() {
  local verb="${1:-begin}"
  local emoji=":ohiru"
  [[ "$verb" = "end" ]] && emoji="${emoji}_owari"

  echo "$emoji: $(date)"
}

function path-list() {
  echo "$PATH" | tr : \\n
}

function notifier() {
  local title=${1}
  local msg=${2+"$@"}
  [[ -f /usr/bin/osascript ]] && /usr/bin/osascript -e 'display notification "'$msg'" with title "'$title'"'
}

function __pomodoro-notifier() {
  notifier "pomodoro さん" ${1+"$@"}
}

function pomodoro() {
  local s=${1:-25}
  local t=${2:-5}
  local p=${3:-15}

  seq 4 | while read x; do
    __pomodoro-notifier "ほら！第 $x ポモドーロよ！！時間は $s 分！始めなさい！"
    gsleep ${s}m
    __pomodoro-notifier "休憩時間よ！時間は $t 分！"
    gsleep ${t}m
  done

  __pomodoro-notifier "長めの休憩ね。時間は $p 分。ちゃんと休むのよ。"
  gsleep ${p}m

  __pomodoro-notifier "はい！休憩終わり！！次よ！次！！"
}
