if ! command -v yq &> /dev/null; then
    zi ice from"gh-r" as"program" cp"yq_linux_amd64 -> $BIN_PATH/yq"
    zi light mikefarah/yq 
fi
