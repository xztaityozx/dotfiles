#!/usr/bin/zsh

# ricty
brew tap sanemat/font
brew install ricty --with-powerline

# any tools
brew install fzf hub ghq zplug go hexyl httpie rargs emojify
type wlinux-setup &> /dev/null || brew install python@2 python neovim node yarn 

# neovim integration
type npm  &> /dev/null && npm i -g neovim
type pip2 &> /dev/null && pip2 install neovim
type pip3 &> /dev/null && pip3 install neovim


