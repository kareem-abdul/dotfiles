#!/bin/bash

git reflog show --pretty=format:'%gs ~ %gd' --date=relative |\
    grep 'checkout:' |\
    grep -oE '[^ ]+ ~ .*' |\
    awk -F~ '!seen[$1]++' |\
    head -n 10 |\
    awk -F' ~ HEAD@{' '{printf("  \033[33m%14s: \033[37m %s\033[0m\n", substr($2, 1, length($2)-1), $1)}'

