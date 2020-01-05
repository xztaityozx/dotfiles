#!/usr/bin/zsh

type go &> /dev/null || (echo "go not installed" && exit 1)

LIST="
github.com/xztaityozx/go-cdx
github.com/justjanne/powerline-go
golang.org/x/tools/cmd/gopls
"

echo $LIST | sed '/^$/d' | xargs -n1 go get 

