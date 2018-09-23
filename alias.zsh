#!bin/zsh

type exa &> /dev/null && alias ls=exa
type libinput-gestures-setup &> /dev/null && alias gesrestart="libinput-gestures-setup restart"
alias rescale="$HOME/.ghq/github.com/xztaityozx/dotfiles/scaleSet.sh"
alias millitime="$HOME/.ghq/github.com/xztaityozx/dotfiles/millitime.sh"
[[ -f "$HOME/.utils/prettyping" ]] && alias ping="$HOME/.utils/prettyping --nolegend"
type bat &> /dev/null && alias cat=bat
[[ -f "$HOME/.utils/diff-so-fancy" ]] && alias diff="$HOME/.utils/diff-so-fancy"
