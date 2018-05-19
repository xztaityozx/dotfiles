# Created by newuser for 5.5

export fpath=($fpath /home/linuxbrew/.linuxbrew/Cellar/hub/2.2.9_1/share/zsh/site-functions /home/linuxbrew/.linuxbrew/Homebrew/completions/zsh/)

# zplug
source /home/linuxbrew/.linuxbrew/Cellar/zplug/2.4.2/init.zsh
touch $ZPLUG_LOADFILE
#zplug 'zplug/zplug', hook-build:'zplug --self-manage'

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
#zplug "chrissicool/zsh-256color"
zplug "b4b4r07/zsh-gomi", if:"which fzf"
#zplug "sorin-ionescu/prezto"


#if ! zplug check --verbose; then
  #printf "Install? [y/N]: "
  #if read -q; then
    #echo; zplug install
  #fi
#fi
# Then, source plugins and add commands to $PATH
zplug load 

# pyenv
eval "$(pyenv init --no-rehash -)"


# cdx
eval "$(cdx_node --init --fuzzy fzf --defopt "--no-output ")"

# fzf
. /home/linuxbrew/.linuxbrew/Cellar/fzf/0.17.3/shell/key-bindings.zsh
. /home/linuxbrew/.linuxbrew/Cellar/fzf/0.17.3/shell/completion.zsh

# powerline
export PATH=$PATH:$HOME/.local/bin
export POWERLINE_CONFIG_COMMAND="$HOME/.local/bin/powerline-config"
powerline-daemon -q
. /home/xztaityozx/.local/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh

# config zsh
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# binding
source ~/.ghq/github.com/xztaityozx/dotfiles/bind.zsh

# hub

# prezto
#if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  #source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
#fi
# alias

alias ls=exa
omnisharp(){
  $HOME/Utils/omnisharp/omnisharp/OmniSharp.exe -p 2000 -s ${@}(:a) 2>&1 >/dev/null &
}
alias gesrestart="libinput-gestures-setup restart"
alias shove="$HOME/.ghq/github.com/progrhyme/shove/bin/shove"
alias rescale="$HOME/.ghq/github.com/xztaityozx/dotfiles/scaleSet.sh"

#if (which zprof > /dev/null 2>&1) ;then
  #zprof
#fi
