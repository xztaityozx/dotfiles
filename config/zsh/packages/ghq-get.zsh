#!/usr/bin/zsh

type ghq &> /dev/null || exit

ROOT="$(ghq root)"

type tilix &> /dev/null && {
  ghq get storm119/Tilix-Themes
  tilixConfig="$HOME/.config/tilix/schemes"
  mkdir -p $tilixConfig

  cp $ROOT/github.com/storm119/Tilix-Themes/Themes/*   $tilixConfig 
  cp $ROOT/github.com/storm119/Tilix-Themes/Themes-2/* $tilixConfig 
}
