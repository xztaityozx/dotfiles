# fzf
version="$(fzf --version|awk '{print $1}')"
. /home/linuxbrew/.linuxbrew/Cellar/fzf/$version/shell/key-bindings.zsh
. /home/linuxbrew/.linuxbrew/Cellar/fzf/$version/shell/completion.zsh

export FZF_DEFAULT_OPTS="-1 -0 --cycle --reverse --height=40% --ansi"
