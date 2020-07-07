#!/usr/bin/zsh

setopt extended_glob

typeset -A abbreviations
abbreviations=(
    "G"    "| grep"
    "X"    "| xargs"
    "T"    "| tail"
    "H"    "| head"
    "W"    "| wc"
    "A"    "| awk '{}'"
    "S"    "| sed ''"
    "DN"   "&> /dev/null"
    "YY"   "| yy"
    "SRS"  "| sort | uniq -c | sort -rn"
    "FC"   "| fcat"
)

magic-abbrev-expand() {
    local MATCH
    LBUFFER=${LBUFFER%%(#m)[-_a-zA-Z0-9]#}
    LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
    zle self-insert

}

no-magic-abbrev-expand() {
    LBUFFER+=' '

}

zle -N magic-abbrev-expand
zle -N no-magic-abbrev-expand
bindkey " " magic-abbrev-expand
bindkey "^x " no-magic-abbrev-expand
