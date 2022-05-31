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
#   - [command] | yy -> copy [command]'s output to clipboard
#   - yy -> copy last command
function yy() {
  CMD=""
  type clip.exe &> /dev/null  && CMD=clip.exe
  type pbcopy &> /dev/null  && CMD=pbcopy
  [[ $"$CMD" == "" ]] && logger.warn "clip.exe, or pbcopy not found" && exit 1

  [ -p /dev/fd/0 ] && $CMD && return
  history | tail -n1 | cut -d ' ' -f4- | $CMD
}

function p() {
  type clip.exe &> /dev/null && logger.warn clip.exeのpaste版はまだ実装してないです
  type pbpaste &> /dev/null && pbpaste
}

# icat STDINからやってきた文字列をパスとしてcatにわたす。複数行あるなら fzf で選択する
function fcat() {
  fzf --preview 'bat --theme Nord --style=numbers --color=always --line-range :500 $(echo {}|awk -F: "{print \$1}")' | awk -F: '{print $1}' | xargs bat --theme Nord 
}

# config, open config file
function config() {
  cd $ZDOTDIR
  local file="$(ls -la|grep -v "^d"|awk '{print $NF}'|fzf)"
  [[ "$file" = "" ]] && logger.warn "fzf was canceled" && return 1

  $EDITOR $file
}

# awk for csv
function cawk() {
  awk -F, "$@"
}

# awk のセパレータを : にしたやつ
function :awk() {
  awk -F: "$@"
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

# YYYYmmddを出力するだけ
function simple-date() {
  date '+%Y%m%d'
}

# 本日分のドキュメントを編集/作成するコマンド
# 日報とかTODOとかを $HOME/Documents/cli-doc/以下に作る
# flags:
#   -f | --file: ファイル名をSTDOUTに出力して終了する
#   -r | --root: ドキュメントルートへのパスをSTDOUTに出力して終了する
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

# hr
# 水平線を出力するだけのコマンド
# params:
#   str: 文字
#   width: 幅
function hr() {
  local str="${1:-=}";
  local width="${2:-80}";
  local length="${#str}"

  local current=0
  while :; do 
    [[ "$current" -ge "$width" ]] && echo "" && return 0
    printf "%s" "$str"
    current=$((current+length))
  done
}

# 文字を大文字にするだけ
function upper() {
  sed 's/./\U&/g'
}

# 文字を小文字にするだけ
function lower() {
  sed 's/./\L&/g'
}

# wrap ( line  ) みたいな感じに包む
#   params:
#     $1: 開始記号
#     $2: 終端記号、省略すると$1
function wrap() {
  sed "s/.*/${1}&${2:-$1}/"
}

# wrapper for tail -f
function catf() {
  type bat &> /dev/null && {
    tail -f ${@} | bat --theme Nord -l log --paging=never
  } || {
    tail -f ${@}
  }
}

# dulp: dbasectl upload latest png
# 特定パス以下の*.pngファイルをリネームしてdbasectlでUploadする
# options:
#   -D, --directory [PATH]   検索するディレクトリ
function dulp() {
  type dbasectl &> /dev/null || { logger.warn "dbasectlが有りません" && return 1 }
  
  declare -a args
  TARGET_DIR=$HOME/Desktop
  YES=0
  DELETE=0
  while ((${#} > 0)); do
    opt="${1}"
    shift
    
    case "${opt}" in
      --directory | -D)
        TARGET_DIR="${1}"
        ;;
      -y | --yes)
        YES=1
        ;;
      -d | --delete)
        DELETE=1
        ;;
      -*)
        logger.warn "不正なオプションです"
        return 1
        ;;
      *)
        args+=("$opt")
        ;;
    esac
  done

  [[ ! -d "${TARGET_DIR}" ]] && {
    logger.warn "${TARGET_DIR}は存在しません"
    return 1
  }

  [[ "${#args}" == 0 ]] && {
    logger.warn "リネーム後のファイル名を指定して下さい"
    return 1
  }

  NEW_FILE="${args[1]}"

  [[ -e "${NEW_FILE}" ]] && [[ "${YES}" == 0 ]] && {
    logger.info "${NEW_FILE}は既に存在します。上書きしますか？"
    read '?y/n> ' ANS
    [[ "${ANS}" != "y" ]] && {
      logger.warn "キャンセルします"
      return 1
    }
  }

  TARGET_FILE="$(exa --sort newest ${TARGET_DIR} | fzf )"
  mv "${TARGET_DIR}/${TARGET_FILE}" "${NEW_FILE}" && dbasectl upload "${NEW_FILE}" | jq -r '.[].markdown' && {
    [[ "${DELETE}" == "1" ]] && rm "${NEW_FILE}"
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

function :e() {
  local files="${*}"
  [[ -p /dev/fd/0 ]] && xargs $EDITOR <(cat -)

  [[ "$files" == "" ]] && $EDITOR || {
    xargs $EDITOR <<< $files
  }
}

function :ve() {
  tmux splitw -h $EDITOR $*
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

  if [[ "$?" != "0" ]] || [[ "$selected" == "" ]]; then
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
      hub switch -c "${2}"
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

