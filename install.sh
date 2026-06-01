#!/bin/bash
set -e

SCRIPT="bin/notaeshell.sh"
TARGET="$HOME/.local/bin/nsh"

# make script executable
chmod +x "$SCRIPT"

# create ~/.local/bin if missing
mkdir -p "$HOME/.local/bin"

# create symlink
ln -sf "$(pwd)/$SCRIPT" "$TARGET"

# add ~/.local/bin to PATH if not already present
if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
    echo "Added ~/.local/bin to PATH in ~/.bashrc"
else
    echo "~/.local/bin already in PATH"
fi

echo "Installation done. Run 'nsh' after restarting your terminal or running 'source ~/.bashrc'"
