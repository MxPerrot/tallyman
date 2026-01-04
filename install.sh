#!/usr/bin/env bash
set -e

BINDIR="$HOME/.local/bin"

mkdir -p "$BINDIR"
install -m 0755 bin/tallyman "$BINDIR/tallyman"

echo "Installed tallyman to $BINDIR"
echo "Make sure ~/.local/bin is in your PATH"
