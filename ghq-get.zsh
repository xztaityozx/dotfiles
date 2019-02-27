#!/usr/bin/zsh

ghq get storm119/Tilix-Themes
mkdir -p ~/.config/tilix/schemes

cp ~/.ghq/github.com/storm119/Tilix-Themes/Themes/* ~/.config/tilix/schemes/
cp ~/.ghq/github.com/storm119/Tilix-Themes/Themes-2/* ~/.config/tilix/schemes/

ghq get saibing/bingo.git
cd ~/.ghq/github.com/saibing/bingo && GO111MODULE=on go install
