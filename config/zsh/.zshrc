# enable completions
autoload -U compinit && compinit

# cdx
eval "$($GOPATH/bin/go-cdx --init)"

# powerline
source $ZDOTDIR/powerline.zsh

# load
ls $ZDOTDIR/*.zsh | while read L; do source $L; done

true


# zplugins
source "$ZDOTDIR/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

zplugin light zsh-users/zsh-autosuggestions
zplugin light zdharma/fast-syntax-highlighting
zplugin load zsh-users/zsh-autosuggestions
zplugin load zsh-users/zsh-completions

# プロファイリング
if (which zprof > /dev/null 2>&1) ;then
  zprof
fi
