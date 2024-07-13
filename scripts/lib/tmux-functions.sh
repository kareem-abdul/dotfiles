#!/bin/bash

source "$(dirname "$0")/lib/date-functions.sh"
source "$(dirname "$0")/lib/colors.sh"

#######################################
# Lists tmux session sorted by access time
# Arguments:
#   format: The format of the output. Refer FORMATS section in tmux MAN. 
#           By default this is session name
#######################################
function _tmux_list_session_sorted() {
    local format=${1:-"#{session_name}"}

    tmux ls -F "#{session_activity} $format" | sort -r | sed 's|^[^ ]* ||'
}

#######################################
# Lists tmux sessions along with relative access time in the output.
# The output is sorted by access time
# Arguments:
#   format: The format of the output. Refer FORMATS section in tmux MAN. 
#           By default this is session name
#######################################
function _tmux_list_session_with_last_accessed() {
    local format=${1:-"#{session_name}"}
    tmux ls -F "#{session_activity} $format" \
        | sort -r \
        | while read -r session_info; do
            local rel_date=$(echo $session_info | awk '{print "@"$1}' | _relative_date)
            local info=$(echo $session_info | sed 's|^[^ ]* ||')
            print_color "$info - $BLACK($rel_date ago)"
        done
}
