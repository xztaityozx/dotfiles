#!/usr/bin/zsh

#zmodload zsh/zprof && zprof

export GOPATH=$HOME/go

# add PATH
export PATH="$PATH:$GOPATH/bin:$HOME/.nimble/bin:/home/linuxbrew/.linuxbrew/bin:$HOME/.local/bin:$HOME/.cargo/bin"

# for plenv
export PLENV_ROOT="$ZDOTDIR/.zinit/plugins/tokuhirom---plenv/"

# neovim
export NVIM_CONFIG_DIR="$HOME/.config/nvim"

# brew
export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"
export fpath=($fpath /home/linuxbrew/.linuxbrew/Homebrew/completions/zsh /home/linuxbrew/.linuxbrew/share/zsh/site-functions)

# fzf
export FZF_DEFAULT_OPTS="-1 -0 --cycle --reverse --height=40% --ansi"

# for WSL
[ "$WT_SESSION" = "" ] && [[ "$WSL_DISTRO_NAME" != "" ]] && {
  export DISPLAY=:0.0
  export GTK_IM_MODULE=fcitx
  export QT_IM_MODULE=fcitx
  export XMODIFIERS="@im=fcitx"
  export DefaultIMModule=fcitx
  xset -r 49
}

# history
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
