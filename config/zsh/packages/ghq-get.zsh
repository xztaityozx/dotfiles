#!/usr/bin/zsh

type ghq &> /dev/null || exit


type tilix &> /dev/null && {
  ghq get storm119/Tilix-Themes
  mkdir -p ~/.config/tilix/schemes

  cp ~/.ghq/github.com/storm119/Tilix-Themes/Themes/* ~/.config/tilix/schemes/
  cp ~/.ghq/github.com/storm119/Tilix-Themes/Themes-2/* ~/.config/tilix/schemes/
}
