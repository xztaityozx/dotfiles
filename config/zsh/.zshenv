#!/usr/bin/zsh

export GOPATH=$HOME/go
export DOTFILES_PATH="$HOME/ghq/github.com/xztaityozx/dotfiles"

# add PATH
export path=(
$DOTFILES_PATH/config/zsh/bin(N-/)
$HOME/.linuxbrew/bin(N-/)
$HOME/.linuxbrew/sbin(N-/)
$GOPATH/bin(N-/)
$HOME/.nimble/bin(N-/)
$HOME/.local/bin(N-/)
$HOME/.cargo/bin(N-/)
$HOME/.dotnet/tools(N-/)
$path
)

# 単語の区切りを変更
export WORDCHARS='*?_.[]~-=&;!#$%^(){}<>'

# neovim
export NVIM_CONFIG_DIR="$HOME/.config/nvim"
export EDITOR="nvim"

# history
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

# rust
#[[ -e "$HOME/.cache/env" ]] && source "$HOME/.cargo/env"

true
