if ! command -v fzf &> /dev/null; then
    zi ice from"gh-r" as"program" cp"fzf -> $ZINIT_PROGRAMS_BIN"
    zi light junegunn/fzf
fi
eval "$(fzf --zsh)"
