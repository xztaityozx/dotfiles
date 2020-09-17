
[[ "$SIMPLE_MODE" = "yes" ]] && {
  source $ZDOTDIR/.zshrc.minimal
  return
}

# set environments
ENV_OS="linux"
ENV_FONT_DIR="$HOME/.local/share/fonts"
ENV_DOT_CONFIG="$HOME/.config"
## for macos
which sw_vers &> /dev/null && {
  ENV_OS="(macos|darwin)"
  ENV_FONT_DIR="$HOME/Library/Fonts"
}

true

# zinit
source ./zinit.zsh

# enable completions
autoload -U compinit && compinit

# load
ls $ZDOTDIR/*.zsh | while read L; do source $L; done

