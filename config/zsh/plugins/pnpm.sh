export PNPM_HOME="${LIB_HOME}/pnpm"
if [ -d "$PNPM_HOME" ]; then
    mkdir -p "$PNPM_HOME"
fi
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
