#!/bin/bash

s=$(date +"%s.%3N")
eval "$@"
t=$(date +"%s.%3N")

echo "scale=1; $t - $s"|bc
