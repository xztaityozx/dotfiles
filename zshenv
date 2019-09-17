[ -d $HOME/.go ] && export GOPATH="$HOME/.go" || export GOPATH="$HOME/go"
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH:/home/xztaityozx/.local/bin:$GOPATH/bin"
export FZF_DEFAULT_OPTS="-1 -0 --cycle --reverse --height=40% --ansi"
export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"
export POWERLINE_CONFIG_COMMAND="$HOME/.local/bin/powerline-config"
export NVIM_CONFIG_DIR="$HOME/.config/nvim"
export PYTHON2_HOST_PROG="/home/linuxbrew/.linuxbrew/bin/python2"
# Append Path

. ~/.ghq/github.com/xztaityozx/dotfiles/path.sh

mount | grep -i "drvfs" &> /dev/null && {
  export DISPLAY=:0.0
  export GTK_IM_MODULE=fcitx
  export QT_IM_MODULE=fcitx
  export XMODIFIERS="@im=fcitx"
  export DefaultIMModule=fcitx
  xset -r 49 # 半角全角点滅防止
}
