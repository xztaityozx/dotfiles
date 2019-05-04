[ -d $HOME/.go ] && export GOPATH="$HOME/.go" || export GOPATH="$HOME/go"
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH:/home/xztaityozx/.local/bin:$GOPATH/bin"
export FZF_DEFAULT_OPTS="-1 -0 --cycle --reverse --height=40% --ansi"
export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"
export POWERLINE_CONFIG_COMMAND="$HOME/.local/bin/powerline-config"
# Append Path

. ~/.ghq/github.com/xztaityozx/dotfiles/path.sh
