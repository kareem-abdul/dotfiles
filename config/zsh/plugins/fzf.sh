if ! command -v fzf &> /dev/null; then
    echo "fzf does not exists. Installing from github releases"
    zi ice from"gh-r" as"program"
    zi light junegunn/fzf
fi
eval "$(fzf --zsh)"
