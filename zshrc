# Created by newuser for 5.5

type brew &> /dev/null || . ~/.zprofile


# zplug
[ -f /home/linuxbrew/.linuxbrew/Cellar/zplug/2.4.2/init.zsh ] && source /home/linuxbrew/.linuxbrew/Cellar/zplug/2.4.2/init.zsh
[ -f $HOME/.zplug/init.zsh ] && source $HOME/.zplug/init.zsh
touch $ZPLUG_LOADFILE

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "b4b4r07/emoji-cli"
  export EMOJI_CLI_KEYBIND="^f"
zplug "b4b4r07/zsh-gomi", if:"which fzf"
zplug load 

# pyenv
#type pyenv &> /dev/null && eval "$(pyenv init --no-rehash -)"


# cdx
eval "$($GOPATH/bin/go-cdx --init)"

# fzf
. /home/linuxbrew/.linuxbrew/Cellar/fzf/$(fzf --version|awk '{print $1}')/shell/key-bindings.zsh
. /home/linuxbrew/.linuxbrew/Cellar/fzf/$(fzf --version|awk '{print $1}')/shell/completion.zsh

# powerline
#powerline-daemon -q
#. $HOME/.local/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh

source $HOME/.ghq/github.com/xztaityozx/dotfiles/powerline.sh

# config zsh
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# binding
source ~/.ghq/github.com/xztaityozx/dotfiles/bind.zsh

# functions
source ~/.ghq/github.com/xztaityozx/dotfiles/function.zsh

# alias
source $HOME/.ghq/github.com/xztaityozx/dotfiles/alias.zsh


true

#type zprof &> /dev/null && zprof | less
