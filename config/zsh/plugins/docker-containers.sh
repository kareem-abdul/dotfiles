if ! command -v docker &>/dev/null; then
    alias docker="podman"
fi

if [ -d "${LIB_HOME}/docker-containers" ]; then
    return 0
fi

git clone https://github.com/kareem-abdul/docker-containers.git ${LIB_HOME}/docker-containers
ln -s ${LIB_HOME}/docker-containers/dc_start $BIN_PATH/dc_start

