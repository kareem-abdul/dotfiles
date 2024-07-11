# Reset
RESET='\033[0m'       # Text Reset

# Regular Colors
BLACK='\033[30m'        # Black
RED='\033[31m'          # Red
GREEN='\033[32m'        # Green
YELLOW='\033[33m'       # Yellow
BLUE='\033[34m'         # Blue
PURPLE='\033[35m'       # Purple
CYAN='\033[36m'         # Cyan
WHITE='\033[37m'        # White

IBLACK='\033[0;90m'       # Black
IRED='\033[0;91m'         # Red
IGREEN='\033[0;92m'       # Green
IYELLOW='\033[0;93m'      # Yellow
IBLUE='\033[0;94m'        # Blue
IPURPLE='\033[0;95m'      # Purple
ICYAN='\033[0;96m'        # Cyan
IWHITE='\033[0;97m'       # White

BOLD='\033[1m'
ITALIC='\033[3m'
UNDERLINE='\033[4m'
BG='\033[7m'
BLINK='\033[6m'

#######################################
# Prints ANSII colored text with reset code at the end to stdout
# Arguments:
#   N number of arguments that can contain color codes
# Usage:
#   print_color "$BOLD$BLUE" "print bold blue"
#######################################
function print_color() {
    echo -e "$@$RESET"
}
