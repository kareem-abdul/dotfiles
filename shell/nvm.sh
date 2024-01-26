#!/bin/bash

export NVM_DIR = "$HOME/.local/lib/nvm/"
if [[ ! -d "$NVM_DIR" ]]; then
    mkdir -p "$NVM_DIR"
    git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
fi

[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

