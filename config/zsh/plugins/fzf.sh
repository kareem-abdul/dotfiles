if ! command -v fzf &> /dev/null; then
    zi ice from"gh-r" as"program" cp"fzf -> $BIN_PATH"
    zi light junegunn/fzf
fi
eval "$(fzf --zsh)"
