# xdg specifications
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_STATE_HOME="${HOME}/.local/state"

export BIN_PATH="${HOME}/.local/bin"
export LIB_HOME="${HOME}/.local/lib"

export JAVA_HOME="${LIB_HOME}/java/default"
export PNPM_HOME="${LIB_HOME}/pnpm"
export PIPX_HOME="${LIB_HOME}/python/pipx_venvs"
export PIPX_BIN_DIR="${LIB_HOME}/python/bin"
export ZINIT_HOME="${XDG_DATA_HOME}/.local/share}/zinit/zinit.git"
export ZINIT_PROGRAMS_BIN="${BIN_PATH}/zinit"

# paths
export PATH="${BIN_PATH}:${PATH}"
export PATH="${JAVA_HOME}:${PATH}"
export PATH="${JAVA_HOME}/bin:${PATH}"
export PATH="${PNPM_HOME}:${PATH}"
export PATH="${ZINIT_PROGRAMS_BIN}:${PATH}"
export PATH="${BIN_PATH}/scripts:${PATH}" # dotfiles scripts
export PATH="${BIN_PATH}/python:${PATH}"

export MANPATH="/usr/local/man:${HOME}/.local/share/man"
