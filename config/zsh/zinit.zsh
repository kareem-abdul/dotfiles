export ZSH_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}/zsh"
source $ZSH_HOME/environments.zsh

# load zinit plugin manager
ZINIT_HOME="${ZINIT_HOME:-${XDG_DATA_HOME}/zinit/zinit.git}"
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
ZINIT_PROGRAMS_BIN="${ZINIT_PROGRAMS_BIN:-${BIN_PATH}/zinit}"
if [ ! -d "$ZINIT_PROGRAMS_BIN" ]; then
    mkdir -p "$ZINIT_PROGRAMS_BIN"
fi

source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab
# zinit light lukechilds/zsh-nvm

zinit snippet OMZP::git
zinit snippet OMZP::command-not-found

# source shell scripts
for plugin in ${ZSH_HOME}/plugins/*;  do
    source "$plugin"
done

autoload -U compinit;
compinit
zinit cdreplay -q

source $ZSH_HOME/keymaps.zsh
source $ZSH_HOME/options.zsh
source $ZSH_HOME/aliases.zsh

