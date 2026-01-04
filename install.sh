#!/usr/bin/env bash
set -euo pipefail

PREFIX="${HOME}/.local"
STYLE_DIR="$HOME/.config/glow/styles"
STYLE_FILE="$STYLE_DIR/tallyman"

echo "Installing tallyman to ${PREFIX}"

# Create target dirs
mkdir -p "${PREFIX}/bin"
mkdir -p "${PREFIX}/lib"
mkdir -p "$STYLE_DIR"

# Copy executable
install -m 0755 bin/tallyman "${PREFIX}/bin/tallyman"

# Copy libraries
cp -r lib "${PREFIX}/lib/tallyman.tmp"
rm -rf "${PREFIX}/lib/tallyman"
mv "${PREFIX}/lib/tallyman.tmp" "${PREFIX}/lib/tallyman"

# Fix internal paths (optional sanity check)
if [ ! -f "${PREFIX}/lib/tallyman/config.sh" ]; then
  echo "Install failed: lib files not found" >&2
  exit 1
fi

if [ ! -f "$STYLE_FILE" ]; then
  install -m 0644 styles/tallyman.json "$STYLE_FILE"
  echo "Installed Glow style: $STYLE_FILE"
else
  echo "Glow style already exists, leaving it untouched."
fi

echo "Install complete."
echo
echo "Make sure ~/.local/bin is in your PATH."
