#!/bin/bash
if [[ ! -d "$HOME/.dotfiles.bak" ]]; then
    mkdir ~/.dotfiles.bak
fi

# tmux
echo "Setting up tmux config"
if [[ -f "$HOME/.tmux.conf" ]]; then
    mv ~/.tmux.conf ~/.dotfiles.bak/.tmux.conf.$(date "+%H:%M:%S:%N")
fi
ln -s $(pwd)/.tmux.conf ~/.tmux.conf
