export NVM_DIR="${XDG_DATA_HOME}/nvm"
if [[ ! -d "$NVM_DIR" ]]; then
    mkdir -p "$NVM_DIR"
    git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
fi

function nvm() {
    echo "NVM not loaded!. Loading now.."

    unset -f nvm
    [ -s "$NVM_DIR/nvm.sh" ] && source $NVM_DIR/nvm.sh
    nvm "$@"
}
