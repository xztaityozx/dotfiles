# enable completions
autoload -U compinit && compinit

# cdx
eval "$($GOPATH/bin/go-cdx --init)"

# powerline
source $ZDOTDIR/powerline.zsh

# load
ls $ZDOTDIR/*.zsh | while read L; do source $L; done

true

# zinit
source "$ZDOTDIR/.zinit/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit load zsh-users/zsh-autosuggestions
zinit load zsh-users/zsh-completions

# プロファイリング
#if (which zprof > /dev/null 2>&1) ;then
  #zprof
#fi
