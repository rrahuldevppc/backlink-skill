#!/bin/bash
# Installs the backlink-builder skill into ~/.claude/skills/
set -e

SRC="$(cd "$(dirname "$0")/skills" && pwd)"
DEST="$HOME/.claude/skills"

mkdir -p "$DEST"
rm -rf "$DEST/backlink-builder"
cp -R "$SRC/backlink-builder" "$DEST/backlink-builder"
echo "installed: backlink-builder -> $DEST/backlink-builder"

# First-run config
CFG="$(cd "$(dirname "$0")" && pwd)/config.yml"
if [ ! -f "$CFG" ]; then
  cp "$(dirname "$CFG")/config.example.yml" "$CFG"
  echo ""
  echo "Created config.yml — OPEN IT AND FILL IT IN before your first batch."
  echo "   $CFG"
else
  echo "config.yml already exists — left untouched."
fi

echo ""
echo "Done. Open a new Claude session, then say:  dispatch banao"
