#!bin/zsh

# 置き換えツール
type hexyl &> /dev/null && alias xxd=hexyl
type gsed &> /dev/null && alias sed=gsed
type ggrep &> /dev/null && alias grep=ggrep
type grm &> /dev/null && alias rm=grm
type gpaste &> /dev/null && alias paste=gpaste
type gmkdir &> /dev/null && alias mkdir=gmkdir

# typo
alias ks=ls
alias ka=ls
alias lks=ls

# cdx
alias cg="cdx -c g"
alias ch="cdx -h"
alias cb="cdx -b"
alias ..="cdx ../"
alias dotfiles="cdx $DOTFILES_PATH"

# hub
alias hs="git status"
alias hpl="git pull"
alias hps="git push"
alias hd="git diff"
alias hl="git log"
alias hst="git stash"

# fcitx
type fcitx &> /dev/null && alias fcitx-autostart="fcitx-autostart &> /dev/null"

# python3
alias py3=python3

# go
alias -s go="go run "

# シンプルなプロンプトなbash
alias simple-bash='PS1="> " bash'

# zinitとかをロードしないzshを起動
alias simple-zsh='SIMPLE_MODE="yes" zsh'
# powerlineだけシンプルにする
alias simple-powerline='SIMPLE_POWERLINE=1 zsh'

# 現在シェルを置き換え
alias relaunch-shell="exec $SHELL -l"

# 文字列をURLエンコード
alias urlize='nkf -WwMQ | tr = %'
alias unurlize='nkf -w --url-input' 

# tmuxをコンフィグを持たせながら起動する
alias tmux="tmux -f $DOTFILES_PATH/config/tmux/tmux.conf"

# date
type gdate &> /dev/null && alias date=gdate
