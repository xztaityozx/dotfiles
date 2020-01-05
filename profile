# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi


# any env
export GOPATH=$HOME/.go
export PATH="/home/linuxbrew/.linuxbrew/sbin:$PATH:/home/linuxbrew/.linuxbrew/bin:$GOPATH/bin:$HOME/.local/bin/"
export POWERLINE_CONFIG_COMMAND="$HOME/.local/bin/powerline-config"
export FZF_DEFAULT_OPTS="-1 -0 --cycle --reverse --height=40% --ansi"
