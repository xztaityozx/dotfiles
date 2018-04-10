# Created by newuser for 5.1.1

#zplug

source ~/.zplug/init.zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "chrissicool/zsh-256color"
zplug "zsh-users/zsh-syntax-highlighting"
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi
zplug load

# history
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000


# brew
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"

# pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
export PATH=$PATH:"$HOME/.local/bin/"

# fzf
. /home/linuxbrew/.linuxbrew/Cellar/fzf/0.17.3/shell/key-bindings.zsh
export FZF_DEFAULT_OPTS="--height=40% --tac --cycle -1 -0 --ansi --reverse"

# powerline
export POWERLINE_CONFIG_COMMAND=~/.local/bin/powerline-config
powerline-daemon -q
. ./.local/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh

# cdx
eval "$(cdx_node --init --fuzzy fzf --defopt '--make --no-output ')"

# alias
alias ls=exa

# completions
export fpath=($fpath /home/linuxbrew/.linuxbrew/Cellar/hub/2.2.9_1/share/zsh/site-functions/ /home/linuxbrew/.linuxbrew/Homebrew/completions/zsh/)
autoload -U compinit && compinit
