if ! command -v dc_start &>/dev/null; then
    zi ice as"program" cp"dc_start -> $BIN_PATH"
    zi light kareem-abdul/docker-containers
fi

export DOCKER_CONTAINER_HOME="$(dirname $ZINIT_HOME)/plugins/kareem-abdul---docker-containers"

if ! command -v docker &>/dev/null; then
    alias docker="podman"
fi
