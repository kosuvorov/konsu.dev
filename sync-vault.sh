#!/bin/bash
# Copies notes marked with 'publish: true' from your Obsidian vault into content/
# Run this before 'npx quartz sync' to update published notes.

VAULT="/Users/konstantin.suvorov/Library/Mobile Documents/iCloud~md~obsidian/Documents/KS"
CONTENT="$(dirname "$0")/content"

# Remove previously synced notes (but keep index.md)
find "$CONTENT" -name "*.md" ! -name "index.md" -delete
find "$CONTENT" -mindepth 1 -type d -empty -delete

# Copy notes with publish: true, preserving folder structure
while IFS= read -r file; do
  rel="${file#$VAULT/}"
  dir="$CONTENT/$(dirname "$rel")"
  mkdir -p "$dir"
  cp "$file" "$CONTENT/$rel"
  echo "  ✓ $rel"
done < <(grep -rl "^publish: true" "$VAULT" --include="*.md")

echo "Done. Run 'npx quartz sync' to commit and deploy."
