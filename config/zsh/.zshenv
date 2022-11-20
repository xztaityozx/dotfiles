#!/usr/bin/zsh

export GOPATH=$HOME/go
export DOTFILES_PATH="$HOME/ghq/github.com/xztaityozx/dotfiles"
export PYTHTONUSERBASE="$HOME/.local/python/"

# add PATH
export path=(
$DOTFILES_PATH/config/zsh/bin(N-/)
/home/linuxbrew/.linuxbrew/bin(N-/)
$HOME/.linuxbrew/bin(N-/)
$HOME/.linuxbrew/sbin(N-/)
$GOPATH/bin(N-/)
$HOME/.nimble/bin(N-/)
$HOME/.local/bin(N-/)
$HOME/.cargo/bin(N-/)
/usr/local/opt/mysql@5.7/bin(N-/)
/usr/local/opt/icu4c/bin(N-/)
$PYTHTONUSERBASE/bin(N-/)
/opt/homebrew/opt/icu4c/bin(N-/)
/opt/homebrew/opt/icu4c/sbin(N-/)
$path
)

# 単語の区切りを変更
export WORDCHARS='*?_.[]~-=&;!#$%^(){}<>'

# for plenv
export PLENV_ROOT="$ZDOTDIR/.zinit/plugins/tokuhirom---plenv/"

# neovim
export NVIM_CONFIG_DIR="$HOME/.config/nvim"
export EDITOR="nvim"

# brew
export MANPATH="$MANPATH:/home/linuxbrew/.linuxbrew/share/man"
export fpath=(
/home/linuxbrew/.linuxbrew/Homebrew/completions/zsh(N-/)
/home/linuxbrew/.linuxbrew/share/zsh/site-functions(N-/)
$HOME/.linuxbrew/share/zsh/site-functions(N-/)
$HOME/.linuxbrew/share/Homebrew/completions/zsh(N-/)
$fpath
)


# history
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

# rust
#[[ -e "$HOME/.cache/env" ]] && source "$HOME/.cargo/env"

true
