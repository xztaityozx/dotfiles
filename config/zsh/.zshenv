#!/usr/bin/zsh

#zmodload zsh/zprof && zprof

export GOPATH=$HOME/go

# add PATH
export path=(
/home/linuxbrew/.linuxbrew/bin(N-/)
$HOME/.linuxbrew/bin(N-/)
$HOME/.linuxbrew/sbin(N-/)
$GOPATH/bin(N-/)
$HOME/.nimble/bin(N-/)
$HOME/.local/bin(N-/)
$HOME/.cargo/bin(N-/)
/usr/local/opt/mysql@5.7/bin(N-/)
/usr/local/opt/icu4c/bin(N-/)
$path
)

# for plenv
export PLENV_ROOT="$ZDOTDIR/.zinit/plugins/tokuhirom---plenv/"

# neovim
export NVIM_CONFIG_DIR="$HOME/.config/nvim"

# brew
export MANPATH="$MANPATH:/home/linuxbrew/.linuxbrew/share/man"
export fpath=(
/home/linuxbrew/.linuxbrew/Homebrew/completions/zsh(N-/)
/home/linuxbrew/.linuxbrew/share/zsh/site-functions(N-/)
$HOME/.linuxbrew/share/zsh/site-functions(N-/)
$HOME/.linuxbrew/share/Homebrew/completions/zsh(N-/)
$fpath
)

# fzf
export FZF_DEFAULT_OPTS="-1 -0 --cycle --reverse --height=40% --ansi"

# for WSL
[ "$WT_SESSION" = "" ] && [[ "$WSL_DISTRO_NAME" != "" ]] && {
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
