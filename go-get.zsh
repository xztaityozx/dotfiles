#!/bin/bash

type go &> /dev/null || (echo "go not installed" && exit 1)

LIST="
github.com/xztaityozx/go-cdx
github.com/justjanne/powerline-go
"

echo $LIST | sed '/^$/d' | xargs -n1 go get 

