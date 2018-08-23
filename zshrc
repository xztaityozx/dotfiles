# Created by newuser for 5.5

export fpath=($fpath /home/linuxbrew/.linuxbrew/Cellar/hub/2.5.0/share/zsh/site-functions /home/linuxbrew/.linuxbrew/Homebrew/completions/zsh/)

# zplug
source /home/linuxbrew/.linuxbrew/Cellar/zplug/2.4.2/init.zsh
touch $ZPLUG_LOADFILE

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "b4b4r07/zsh-gomi", if:"which fzf"
zplug load 

# pyenv
eval "$(pyenv init --no-rehash -)"


# cdx
eval "$($HOME/.go/bin/go-cdx --init)"

# fzf
. /home/linuxbrew/.linuxbrew/Cellar/fzf/0.17.4/shell/key-bindings.zsh
. /home/linuxbrew/.linuxbrew/Cellar/fzf/0.17.4/shell/completion.zsh

# powerline
powerline-daemon -q
. /home/xztaityozx/.local/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh

# config zsh
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# binding
source ~/.ghq/github.com/xztaityozx/dotfiles/bind.zsh

# alias
alias ls=exa
alias gesrestart="libinput-gestures-setup restart"
alias shove="$HOME/.ghq/github.com/progrhyme/shove/bin/shove"
alias rescale="$HOME/.ghq/github.com/xztaityozx/dotfiles/scaleSet.sh"
alias millitime="$HOME/.ghq/github.com/xztaityozx/dotfiles/millitime.sh"
