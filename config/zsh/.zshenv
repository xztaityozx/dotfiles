#!/usr/bin/zsh

export GOPATH=$HOME/go
export DOTFILES_PATH="$HOME/ghq/github.com/xztaityozx/dotfiles"

# add PATH
export path=(
$DOTFILES_PATH/config/zsh/bin(N-/)
$GOPATH/bin(N-/)
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

if type brew &> /dev/null; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

true
