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
alias hs="hub status"
alias hac="hub add -A && hub commit -m"
alias hpl="hub pull"
alias hps="hub push"
alias hsw="hub switch"
alias hg="hub grep"
type rg &> /dev/null && unalias hg && alias hg="rg --vimgrep"
alias hd="hub diff"
alias hl="hub log"
alias hst="hub stash"
alias hsf="hub status --short | fzf -m"
alias hswf="hub branch --list | fzf | xargs hub switch"

# fcitx
type fcitx &> /dev/null && alias fcitx-autostart="fcitx-autostart &> /dev/null"

# for touchpad gesture
type libinput-gestures-setup &> /dev/null && alias gesrestart="libinput-gestures-setup restart"

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

# googlerをw3mで起動したい
type w3m &> /dev/null && type googler &> /dev/null && alias googler="BROWSER=w3m googler"

# :e で EDITOR を起動する
#[[ -z "$EDITOR" ]] || alias :e="$EDITOR"

# tmuxをコンフィグを持たせながら起動する
alias tmux="tmux -f $DOTFILES_PATH/config/tmux/tmux.conf"

# ゼロ幅スペース
alias zws='echo -e "\U200B"'
