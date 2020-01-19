#!bin/zsh

# 置き換えツール
type exa &> /dev/null && alias ls="exa --git"
type bat &> /dev/null && alias cat="bat --theme TwoDark"
type hexyl &> /dev/null && alias xxd=hexyl
type httpie &> /dev/null && alias curl=httpie

# typo
alias ks=ls
alias ka=ls

# cdx
alias cg="cdx -c g"
alias ch="cdx -h"
alias cb="cdx -b"
alias ..="cdx ../"

# git
[ -f "$(brew --prefix)/bin/git" ] && {
  alias git=$(brew --prefix)/bin/git
}

# hub
alias hc="hub checkout"
alias hs="hub status"
alias hac="hub add -A && hub commit -m"
alias hpl="hub pull"
alias hps="hub push"
alias hub-update="hub add -A && hub commit -m 'update' && hub push"
alias hsw="hub switch"

# fcitx
alias fcitx-autostart="fcitx-autostart &> /dev/null"

# for touchpad gesture
alias gesrestart="libinput-gestures-setup restart"

# go
alias -s go="go run "

# windows terminal
[ "$WT_SESSION" != "" ] && alias open-wterm-settiong="nvim /home/xztaityozx/winhome/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/profiles.json"
