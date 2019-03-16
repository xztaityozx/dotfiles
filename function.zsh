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
