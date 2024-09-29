if ! command -v yq &> /dev/null; then
    zi ice from"gh-r" as"program" cp"yq -> $BIN_PATH"
    zi light mikefarah/yq 
fi
