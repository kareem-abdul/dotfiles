if ! command -v dc_start &>/dev/null; then
    zi ice as"program" cp"dc_start -> $ZINIT_PROGRAMS_BIN"
    zi light kareem-abdul/docker-containers
fi

export DOCKER_CONTAINERS_HOME="$(dirname $ZINIT_HOME)/plugins/kareem-abdul---docker-containers"

if ! command -v docker &>/dev/null; then
    alias docker="podman"
fi
