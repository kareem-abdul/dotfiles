#!/usr/bin/env bash

function _read_from_stdin() {
    if [[ -p /dev/stdin ]]; then
        echo "$(cat -)"
        return 0
    fi
    echo ""
    return 1
}
