#!/bin/bash

usage() {
    cat <<doc
Usage: $(basename "$0") [OPTIONS] [ref-branch]

Prints rows of latest branches in order of commit date with behind and ahead commits based on ref-branch

Options:
    --help      : prints help
    -c          : no of rows in the result
    --all       : wheather refer remote branches as well
doc
exit 1
}

err() { echo "$@" >&2; exit 1; }

r() {
    local all=0
    local count=20;
    while getopts "hc:g:f-:" OPT
    do
      if [ "$OPT" = "-" ]; then # adds support for long args in getopts (along with need_args)
        OPT="${OPTARG}"
      fi
      case "${OPT}" in
        h)       usage; ;;
        c)       count="$OPTARG"; ;;
        all)     all=1; ;;
        ??* )    err "$(basename "$0"): illegal option -- --$OPT" ;;
        ?)       err ;;
      esac
    done
    shift $((OPTIND - 1))

    local refbranch=$1;
    local format='%(refname:short)|%(HEAD)%(color:yellow)%(refname:short)|%(color:bold green)%(committerdate:relative)|%(color:blue)%(subject)|%(color:magenta)%(authorname)%(color:reset)'

    if [ -z "$refbranch" ]; then
        if git rev-parse --verify origin/main >/dev/null 2>&1; then
            refbranch="origin/main"
        else
            refbranch="origin/master"
        fi
    fi

    if ! git rev-parse --verify $refbranch >/dev/null 2>&1; then
        err "$refbranch does not exist"
    fi

    local ref=$(git for-each-ref \
        --sort=-committerdate \
        refs/heads $([ "$all" -eq "1" ] && echo "refs/remotes" )\
        --format="$format" \
        --color=always \
        --count=${count:-20});

    local formatted=$'ahead|behind|branch|lastcommit|message|author\n';
    while read -r line; do
        local branch=$(echo "$line" | awk 'BEGIN { FS = "|" }; { print $1 }' | tr -d '*');
        local ahead=$(git rev-list --count "${refbranch}..${branch}");
        local behind=$(git rev-list --count "${branch}..${refbranch:-origin/main}");
        local colorline=$(echo "$line" | sed 's/^[^|]*|//')
        formatted+="$ahead|$behind|$colorline"
        formatted+=$'\n'
    done <<< "$ref" # | (echo "ahead|behind|branch|lastcommit|message|author" && cat)  | column -ts'|'
    echo "$formatted" | column -ts'|'

}
r $@
