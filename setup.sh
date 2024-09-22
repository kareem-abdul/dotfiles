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
    [[ ! -d "$HOME/.local/bin" ]] && mkdir -p $HOME/.local/bin
    ln -s $PWD/scripts $HOME/.local/bin/scripts
    echo "scripts" >> installed
    echo "make sure that the path $HOME/.local/bin/scripts is in your PATH variable"
fi

# configs
for path in $PWD/config/*; do
    config=$(basename $path)
    if ! isInstalled "$config"; then
        echo "Configuring $config"
        dest="$HOME/.config/$config"
        if [[ -f "$dest" || -d "$dest" ]]; then
            echo "Existing $config config found at $dest. Backing it up to $HOME/.dotfiles.bak"
            mv $dest ~/.dotfiles.bak/$config.$(date "+%H:%M:%S:%N").bak
        fi
        ln -s $path $HOME/.config/$config
        echo "$config" >> installed
    fi
done

# zsh
if ! isInstalled "zshrc"; then
    echo "setting up zshrc"
    dest="$HOME/.zshrc"
    if [[ -f "$dest" ]]; then
        echo "Existing zshrc found. Backing it up to $HOME/.dotfiles.bak"
        mv $dest ~/.dotfiles.bak/.zshrc.$(date "+%H:%M:%S:%N").bak
    fi
    ln -s $PWD/.zshrc $dest
    echo "zshrc" >> installed
fi

