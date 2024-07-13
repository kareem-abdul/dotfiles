#!/usr/bin/env bash

source "$(dirname "$0")/util-functions.sh"

#######################################
# prints time relative to current time
# Arguments:
#   The time from which the relative time should be shown
# Usage:
#   $ _relative_date "02/06/2024"
#   => 24h
#   $ _relative_date "01/06/2024"
#   => 2d
#######################################
function _relative_date() {
    local input_date_time=$(_read_from_stdin || echo "$@")
    if [[ -z $input_date_time ]]; then
        input_date_time=$(date +%s);
    else
        input_date_time=$(date -d "$input_date_time" +%s)
    fi
    local current_time=$(date +%s)
    local diff=$(( $current_time - $input_date_time ))

    local unit="s"
    local factor=1
    if [ "$diff" -lt 60 ]; then
        echo "${diff}s"
        return 0
    elif [ "$diff" -lt 3600 ]; then
        echo "$(( $diff / 60 ))m"
        return 0
    elif [ "$diff" -lt 86400 ]; then
        echo "$(( $diff / 3600 ))h"
        return 0
    fi
    echo "$(( $diff / 86400 ))d"
}
