#!/bin/bash

mkdir ~/.dotfiles.bak
# tmux
mv ~/.tmux.conf ~/.dotfiles.bak
ln -s .tmux.conf ~/.tmux.conf

