#!/bin/bash

cat Dictionary.json |jq -r '.Dictionary[]|.key, .value'|while read key; do read value; echo -n "s@$key@$value@g;"; done > extracted.txt
sed "$(cat ./extracted.txt)"|win32yank.exe -i
