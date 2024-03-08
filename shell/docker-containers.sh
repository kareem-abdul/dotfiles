#!/bin/bash

alias cstart="$HOME/.local/lib/docker-containers/start.sh"
if ! which docker 2>/dev/null; then
    alias docker="podman"
fi

if [ -d "$HOME/.local/lib/docker-containers" ]; then
    exit 0
fi

git clone https://github.com/kareem-abdul/docker-containers.git ~/.local/lib/docker-containers

