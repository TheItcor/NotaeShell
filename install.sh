#!/bin/bash
set -e

# Resolve script and target paths
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPT="$SCRIPT_DIR/bin/notaeshell.sh"
TARGET="$HOME/.local/bin/nsh"
BIN_DIR="$HOME/.local/bin"

# Ensure target directory exists
mkdir -p "$BIN_DIR"
chmod +x "$SCRIPT"

# Create a symlink; try relative first, fallback to absolute
if command -v realpath >/dev/null 2>&1; then
    REL_PATH="$(realpath --relative-to="$BIN_DIR" "$SCRIPT")"
    ln -sf "$REL_PATH" "$TARGET"
else
    ln -sf "$SCRIPT" "$TARGET"
fi

# Determine which shell config to update
detect_shell_r() {
    # Use $SHELL to guess the user's login shell...
    case "$(basename "$SHELL")" in
        bash)
            RC="$HOME/.bashrc"
            LINE='export PATH="$HOME/.local/bin:$PATH"'
            ;;
        zsh)
            RC="$HOME/.zshrc"
            LINE='export PATH="$HOME/.local/bin:$PATH"'
            ;;
        fish)
            RC="$HOME/.config/fish/config.fish"
            LINE="fish_add_path \$HOME/.local/bin"
            # Ensure fish config directory exists
            mkdir -p "$(dirname "$RC")"
            ;;
        *)
            echo "Warning: unknown shell '$SHELL'. You may need to add $BIN_DIR to your PATH manually."
            return
            ;;
    esac

    # Check if the line is already present in the config file (exact match)
    if [ -f "$RC" ] && grep -Fxq "$LINE" "$RC"; then
        echo "$BIN_DIR is already in PATH according to $RC"
    else
        echo "$LINE" >> "$RC"
        echo "Added $BIN_DIR to PATH in $RC"
    fi
}

detect_shell_rc

# Fin
echo ""
echo "Installation complete. To start using 'nsh' immediately update your $SHELL config, for example:"
echo "source ~/.bashrc"
