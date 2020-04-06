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
