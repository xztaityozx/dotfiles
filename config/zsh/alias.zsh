#!bin/zsh

# 置き換えツール
type exa &> /dev/null && alias ls="exa --git"
type bat &> /dev/null && alias cat="bat --theme TwoDark"
# {{{
  # $_.cat とすれば、直前にlsとかnvimしたファイルをcatできる。あんまつかわん
  alias -s cat='(){cat ${1/.cat/}}'
  alias catf="(){tail -f \${@} | cat -l log --paging=never}"
  alias fcat="fzf --preview 'bat --theme TwoDark --style=numbers --color=always --line-range :500 {}' | :awk '{print \$1}' | icat"
# }}}
type hexyl &> /dev/null && alias xxd=hexyl
type httpie &> /dev/null && alias curl=httpie
type gsed &> /dev/null && alias sed=gsed
type ggrep &> /dev/null && alias grep=ggrep
type grm &> /dev/null && alias rm=grm

# typo
alias ks=ls
alias ka=ls
alias lks=ls

# cdx
alias cg="cdx -c g"
alias ch="cdx -h"
alias cb="cdx -b"
alias ..="cdx ../"
alias cdoc='cdx $(doc -r)'

# hub
alias hc="hub checkout"
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
alias hub-push-current="hub push origin HEAD"
alias hsf="hub status --short | fzf -m"

# lazygit
type lazygit &> /dev/null && alias lg=lazygit

# fcitx
type fcitx &> /dev/null && alias fcitx-autostart="fcitx-autostart &> /dev/null"

# for touchpad gesture
type libinput-gestures-setup &> /dev/null && alias gesrestart="libinput-gestures-setup restart"

# python3
alias py3=python3

# go
alias -s go="go run "

# perl
alias -s pl="perl -Ilib"
alias -s psgi="carton exec -- plackup -Ilib"
alias care="carton exec"
alias ple="plenv exec"
alias care-run="carton exec perl -Ilib"

# シンプルなプロンプトなbash
alias simple-bash='PS1="> " bash'

# zinitとかをロードしないzshを起動
alias simple-zsh='SIMPLE_MODE="yes" zsh'

# 現在シェルを置き換え
alias relaunch-shell="exec $SHELL -l"

# 文字列をURLエンコード
alias urlize='nkf -WwMQ | tr = %'
alias unurlize='nkf -w --url-input' 
