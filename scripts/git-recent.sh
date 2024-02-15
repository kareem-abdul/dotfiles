#!/bin/bash
r() {
    local refbranch=$1;
    local count=$2;
    local format='%(refname:short)|%(HEAD)%(color:yellow)%(refname:short)|%(color:bold green)%(committerdate:relative)|%(color:blue)%(subject)|%(color:magenta)%(authorname)%(color:reset)'

    local ref=$(git for-each-ref \
        --sort=-committerdate \
        refs/heads refs/remotes \
        --format="$format" \
        --color=always \
        --count=${count:-20});

    local formatted=$'ahead|behind|branch|lastcommit|message|author\n';
    while read -r line; do
        local branch=$(echo "$line" | awk 'BEGIN { FS = "|" }; { print $1 }' | tr -d '*');
        local ahead=$(git rev-list --count "${refbranch:-origin/main}..${branch}");
        local behind=$(git rev-list --count "${branch}..${refbranch:-origin/main}");
        local colorline=$(echo "$line" | sed 's/^[^|]*|//')
        formatted+="$ahead|$behind|$colorline"
        formatted+=$'\n'
    done <<< "$ref" # | (echo "ahead|behind|branch|lastcommit|message|author" && cat)  | column -ts'|'
    echo "$formatted" | column -ts'|'

}
r
