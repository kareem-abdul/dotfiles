#!/bin/bash

export NVM_DIR = "${XDG_DATA_HOME}/nvm"
if [[ ! -d "$NVM_DIR" ]]; then
    mkdir -p "$NVM_DIR"
    git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
fi

[ -s "$NVM_DIR/nvm.sh" ] && source $NVM_DIR/nvm.sh --no-use
