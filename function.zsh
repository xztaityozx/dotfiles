#!/usr/bin/zsh

function ci-status(){
  [ "$(hub ci-status)" = "no st" ] && 
    echo "There is no CI/CD in this repository/current branch" && return 1

  echo "["$(date)"] Begin Check CI Status"

  st="$(hub ci-status)"
  while [ "$st" = "pending" ]; do 
    sleep ${3:-"10"}s
    st="$(hub ci-status)"
  done

  MSG=${1:-"CIさんからお手紙付きましたよ！マスター！"}
  if [ "$st" = "success" ]; then
    MSG="$MSG"成功のようですね！
  else 
    MSG="$MSG"失敗したらしいですね！
  fi
  echo "$MSG" | seikasay -cid ${2:-"2002"} -stdin
}

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

# generate password
# usage: 
#   - gen-password [number of passwords] [length of password]
function gen-passwd(){
  local cnt=${2:-10}
  local w=${1:-10}
  cat /dev/urandom|base64|head -n5| fold -w$w | head -n$cnt
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
  type xclip 2>&1 > /dev/null && echo -n "$text" | xclip -selection c return 0
  # xsel 
  type xsel 2>&1 > /dev/null && echo -n "$text" | xsel -b && return 0

  logger.warn "clip.exe, xclip or xsel not found"
}

