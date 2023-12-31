#!/bin/bash
if [[ ! -d "$HOME/.dotfiles.bak" ]]; then
    mkdir ~/.dotfiles.bak
fi 

pwd | read PWD
if [[ ! -f "$PWD/installed" ]]; then
    touch $PWD/installed
fi

function isInstalled() {
    local installed=$(grep "$1" $PWD/installed)
    if [[ "$installed" == "" ]]; then
        return 1;
    fi
    return 0;
}

# scripts
if ! isInstalled "scripts"; then
    echo "setting up scripts"
    for script in $(pwd)/.local/bin/*; do
        echo "linking $script"
        ln -s $script ~/.local/bin/$(basename $script)
    done
    echo "scripts" >> installed
fi

# tmux
if ! isInstalled "tmux"; then
    echo "Setting up tmux config"
    if [[ -f "$HOME/.tmux.conf" ]]; then
        mv ~/.tmux.conf ~/.dotfiles.bak/.tmux.conf.$(date "+%H:%M:%S:%N")
    fi
    ln -s $(pwd)/.tmux.conf ~/.tmux.conf
    echo "tmux" >> installed
fi

# nvim
if ! isInstalled "nvim"; then 
    echo "setting up nvim config"
    if [[ -d "$HOME/.config/.nvim" ]]; then
        mv ~/.config/nvim ~/.dotfiles.bak/.config/nvim.$(date "+H:%M:%S:%N")
    fi
    ln -s $(pwd)/.config/nvim ~/.config/nvim
    echo "nvim" >> installed
fi
