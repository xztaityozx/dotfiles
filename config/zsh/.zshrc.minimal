# 最小構成のzshrc
type git &> /dev/null || return

PURE_DIR="$ZDOTDIR/pure"

[[ -e "$PURE_DIR" ]] || {
  mkdir -p "$PURE_DIR"
  git clone https://github.com/sindresorhus/pure.git "$PURE_DIR"
}

export fpath=(
$fpath
$PURE_DIR(N-/)
)

autoload -U promptinit; promptinit
prompt pure

[[ -f "$ZDOTDIR/.zinit/zinit.zsh" ]] && source "$ZDOTDIR/.zinit/zinit.zsh"
[[ -f "$ZDOTDIR/.zinit/bin/zinit.zsh" ]] && source "$ZDOTDIR/.zinit/bin/zinit.zsh" 
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# zsh-utils
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
