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
    echo "setting up scripts to ~/.local/bin"
    ln -s $PWD/scripts ~/.local/bin/scripts
    echo "scripts" >> installed
    echo "make sure that the path $HOME/.local/bin/scripts is in your PATH variable"
fi

# tmux
if ! isInstalled "tmux"; then
    echo "Setting up tmux config"
    if [[ -f "$HOME/.tmux.conf" ]]; then
        mv ~/.tmux.conf ~/.dotfiles.bak/.tmux.conf.$(date "+%H:%M:%S:%N").bak
    fi
    if [[ -d "$HOME/.config/tmux" ]]; then
	mv ~/.config/tmux ~/.dotfiles.bak/tmux.$(date "+%H:%M:%S:%N").bak
    fi
    ln -s $PWD/config/tmux ~/.config/tmux
    echo "tmux" >> installed
fi

# nvim
if ! isInstalled "nvim"; then 
    echo "setting up nvim config"
    if [[ -d "$HOME/.config/.nvim" ]]; then
        mv ~/.config/nvim ~/.dotfiles.bak/.config/nvim.$(date "+H:%M:%S:%N").bak
    fi
    ln -s $PWD/config/nvim ~/.config/nvim
    echo "nvim" >> installed
fi
