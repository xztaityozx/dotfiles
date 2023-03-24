#!/usr/bin/zsh

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
#   - [command] | yy -> copy [command]'s output to clipboard
#   - yy -> copy last command
function yy() {
  CMD=""
  type clip.exe &> /dev/null  && CMD=clip.exe
  type pbcopy &> /dev/null  && CMD=pbcopy
  [[ $"$CMD" == "" ]] && logger.warn "clip.exe, or pbcopy not found" && exit 1

  [ -p /dev/fd/0 ] && $CMD && return
  history | tail -n1 | sel --remove-empty 2: | $CMD
}

function p() {
  type powershell.exe &>/dev/null && powershell.exe -c "Get-Clipboard" && return
  type pbpaste &> /dev/null && pbpaste && return
}

# fcat STDINからやってきた文字列をパスとしてcatにわたす。複数行あるなら fzf で選択する
function fcat() {
  fzf --preview 'bat --theme Nord --style=numbers --color=always --line-range :500 $(echo {}|awk -F: "{print \$1}")' | awk -F: '{print $1}' | xargs bat --theme Nord 
}

# $PATH を見やすく表示するだけ
function path-list() {
  echo "$PATH" | tr : \\n
}

# ど゛う゛し゛て゛な゛ん゛だ゛よ゛お゛お゛お゛お゛お゛お゛お゛お゛お゛お゛お゛お゛お゛お゛お゛
function fujitatsulize() {
  cat | sed 's/./&゛/g'
}

# wget wgetのラッパー、自動で/tmp/zsh/wgetに移動して、作業ディレクトリとしてつかう
function wget-tmp() {
  local dir="$TMPPREFIX/wget"

  echo "$dirで作業する？"
  yesno
  [[ "$?" == "0" ]] && {
    mkdir -p ${dir}
    cd ${dir}
  }
  \wget "$@"
}
alias wget=wget-tmp

# 本日分のドキュメントを編集/作成するコマンド
# 日報とかTODOとかを $HOME/Documents/cli-doc/以下に作る
function doc() {
  local docDir="$HOME/Documents/cli-doc"

  [[ ! -e "$docDir" ]] && mkdir -p "$docDir"

  cd $docDir

  "$EDITOR" "$docDir/worklog/$(date +%Y/%m.md)"
}

# fzf を使った yes/no プロンプト
function yesno() {
  local res="$(echo 'yes
no' | fzf)"
  [[ "$res" == yes ]] && return 0
  return 1
}

# wrapper for tail -f
function catf() {
  type bat &> /dev/null && {
    tail -f ${@} | bat --theme Nord -l log --paging=never
  } || {
    tail -f ${@}
  }
}

# tmux内でmanを見るとき、左に開く
function man() {
  if [[ ! -z "$TMUX" ]] then
    tmux splitw -h man "$@"
  else
    command man "$@"
  fi
}

# historyコマンドとshutdownコマンドは履歴に残さない
function zshaddhistory() {
  [[ ! "${1}" =~ "shutdown|history" ]]
}

# cdxの履歴をdistinctする
function cdx-history-clean-up() {
  [[ -e $HOME/.config/go-cdx/history ]] && {
    sort -u $HOME/.config/go-cdx/history | xargs -n1 -I@ -P5 zsh -c "ls @ &>/dev/null && echo @" | sponge $HOME/.config/go-cdx/history
  }
}

# $1 桁のhexを取得する。lower case
function randhex() {
  local digits=${1:-10}
  shuf -re {a..f} {0..9} -n "$digits" | tr -d '\n' | awk 4
}

function randid() {
  local digits="${1:-10}"
  shuf -re {0..9} {@..Z} {a..z} _ . : -n "$digits" | tr -d '\n' | awk 4
}

function take() {
  local number="${1:-10}"
  awk -v n="$number" 'NR==1,NR==n'
}

function skip() {
  local number="${1:-10}"
  awk -v n="$number" 'NR==n+1,0'
}

function readme() {
  local root="$(git rev-parse --show-cdup)"
  if [[ "$?" != "0" ]]; then
    root="$PWD"
  fi

  local selected="$(fd 'readme' $root | fzf)"

  if [[ "$selected" == "" ]]; then
    logger.warn なかったかfzfがキャンセルされたっぽいね
    return
  fi

  bat --theme=TwoDark -l markdown "$selected"
}

function hsw() {
  if ! git status &> /dev/null; then
    logger.warn "gitリポジトリじゃなくない？？？"
    return 1
  fi

  if [[ "${#}" == "2" ]]; then
    if [[ "${1}" == "-c" ]]; then
      git switch -c "${2}"
      return 0
    else
      logger.warn "引数2個渡されても困る"
      return 1
    fi
  fi

  local branch="${1}"
  if [[ -z "$branch" ]]; then
    branch="$(git branch --list | fzf | sel -- -1)"
    [[ "$?" != 0 ]] && {
      logger.warn キャンセルしたかgit branchが失敗したかな
      return 1
    }
  fi

  [[ "$branch" == "$(git branch --show-current)" ]] && {
    logger.info "いま $branch なのでgit switchしなかったよ"
    return 0
  }

  git switch "$branch"
}

function CamelCase() {
  sed 's/\(_\)\([a-z]\)/\U\2/g;s/^\([a-z]\)/\U\1/g'
}

function snake_case() {
  sed 's/\([a-z]\)\([A-Z]\)/\1_\2/g' | tr '[:upper:]' '[:lower:]'
}
