#!bin/zsh

# 置き換えツール
type hexyl &> /dev/null && alias xxd=hexyl
type gsed &> /dev/null && alias sed=gsed
type ggrep &> /dev/null && alias grep=ggrep
type grm &> /dev/null && alias rm=grm
type gpaste &> /dev/null && alias paste=gpaste
type gmkdir &> /dev/null && alias mkdir=gmkdir
type gawk &> /dev/null && alias awk=gawk

# typo
alias ks=ls
alias ka=ls
alias lks=ls
alias ｔむｘ=tmux

alias dotfiles="cd $DOTFILES_PATH"
alias cg='ghq list --full-path | cd'

# hub
alias hs="git status"
alias hpl="git pull"
alias hd="git diff"
alias hl="git log"
alias hst="git stash"

# シンプルなプロンプトなbash
alias simple-bash='PS1="> " bash'

# powerlineだけシンプルにする
alias simple-zsh='SIMPLE_POWERLINE=1 zsh'

# 現在シェルを置き換え
alias relaunch-shell="exec $SHELL -l"

# 文字列をURLエンコード
alias urlize='nkf -WwMQ | tr = %'
alias unurlize='nkf -w --url-input' 

# tmuxをコンフィグを持たせながら起動する
alias tmux="tmux -f $DOTFILES_PATH/config/tmux/tmux.conf"

# date
type gdate &> /dev/null && alias date=gdate

# エディタ系
alias :e="$EDITOR"
alias :ve="tmux splitw -h $EDITOR"

