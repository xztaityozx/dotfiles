#!/usr/bin/zsh

# brew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

# any tools
brew install fzf hub ghq go hexyl httpie rargs exa bat neovim python@3 jq

# neovim integration
type pip3 &> /dev/null && pip3 install pynvim
