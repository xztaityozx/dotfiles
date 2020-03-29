# fzf

prefix="/usr/share/fzf"
type brew &>/dev/null && prefix="/home/linuxbrew/.linuxbrew/opt/fzf/shell"

source $prefix/completion.zsh
source $prefix/key-bindings.zsh

export FZF_DEFAULT_OPTS="-1 -0 --cycle --reverse --height=40% --ansi"
