# ZSH options
HISTSIZE=10000000
HISTFILE=$HOME/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory # append history instead of overite
setopt sharehistory # share history to all shells at the same time
setopt hist_ignore_space # ignore commands with space before them
setopt extended_history 
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups
setopt hist_reduce_blanks


