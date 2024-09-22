#!/bin/bash

if ! command -v docker 2>/dev/null; then
    alias docker="podman"
fi

if [ -d "${LIB_PATH}/docker-containers" ]; then
    exit 0
fi

git clone https://github.com/kareem-abdul/docker-containers.git ${LIB_PATH}/docker-containers
ln -s ${LIB_PATH}/docker-containers/dc_start $BIN_PATH/dc_start

