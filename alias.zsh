#!bin/zsh

type exa &> /dev/null && alias ls="exa --git"
type libinput-gestures-setup &> /dev/null && alias gesrestart="libinput-gestures-setup restart"
alias rescale="$HOME/.ghq/github.com/xztaityozx/dotfiles/scaleSet.sh"
alias millitime="$HOME/.ghq/github.com/xztaityozx/dotfiles/millitime.sh"
[[ -f "$HOME/.utils/prettyping" ]] && alias ping="$HOME/.utils/prettyping --nolegend"
type bat &> /dev/null && alias cat="bat --theme TwoDark"
[[ -f "$HOME/.utils/diff-so-fancy" ]] && alias diff="$HOME/.utils/diff-so-fancy"
[[ -f $HOME/.utils/nvim.appimage ]] && alias nvim="$HOME/.utils/nvim.appimage" && alias vim="$HOME/.utils/nvim.appimage"
type hexyl &> /dev/null && alias xxd=hexyl
type httpie &> /dev/null && alias curl=httpie
[[ -f "/mnt/c/Users/sldl77/App/SeikaCenter20190108u/SeikaSay/seikasay.exe" ]] && alias seikasay=/mnt/c/Users/sldl77/App/SeikaCenter20190108u/SeikaSay/seikasay.exe



# typo
alias ks=ls
alias ka=ls

# cdx
alias cg="cdx -c g"
alias ch="cdx -h"
alias cb="cdx -b"

# hub
alias hc="hub checkout"
alias hs="hub status"
alias hac="hub add -A && hub commit -m"
alias hpl="hub pull"
alias hps="hub push"
alias hub-update="hub add -A && hub commit -m 'update' && hub push"

# docker
alias dps="sudo docker ps"
alias dr="sudo docker run"

# docker-compose
alias d-compose="sudo docker-compose"
alias dcd="sudo docker-compose down"
alias dcu="sudo docker-compose up"

# complete
type heroku &> /dev/null && HEROKU_AC_ZSH_SETUP_PATH=/home/xztaityozx/.cache/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

true
