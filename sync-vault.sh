#!/bin/bash
# Copies notes marked with 'publish: true' from your Obsidian vault into content/
# Also copies images referenced in those notes.
# Run this before 'npx quartz sync' to update published notes.

set -e

VAULT="/Users/konstantin.suvorov/Library/Mobile Documents/iCloud~md~obsidian/Documents/KS"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONTENT="$SCRIPT_DIR/content"

echo "Vault:   $VAULT"
echo "Content: $CONTENT"
echo ""

# --- Cleanup: remove previously synced notes (but keep index.md) and images ---
find "$CONTENT" -name "*.md" ! -name "index.md" -delete
find "$CONTENT" \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.gif" -o -name "*.webp" -o -name "*.svg" \) -delete 2>/dev/null || true
find "$CONTENT" -mindepth 1 -type d -empty -delete 2>/dev/null || true

# --- Find published notes ---
PUBLISHED_LIST=$(mktemp)
grep -rl "^publish: true" "$VAULT" --include="*.md" > "$PUBLISHED_LIST"

NOTE_COUNT=$(wc -l < "$PUBLISHED_LIST" | tr -d ' ')
echo "Found $NOTE_COUNT published notes:"

# --- Copy notes ---
while IFS= read -r file; do
  rel="${file#$VAULT/}"
  dir="$CONTENT/$(dirname "$rel")"
  mkdir -p "$dir"
  cp "$file" "$CONTENT/$rel"
  echo "  ✓ $rel"
done < "$PUBLISHED_LIST"

echo ""
echo "Looking for image references..."

# --- Collect all referenced image filenames into one list ---
IMAGES_LIST=$(mktemp)
while IFS= read -r file; do
  # Match Obsidian's ![[image.png]] (with optional |size) and standard ![alt](image.png)
  grep -oE '!\[\[[^]]+\.(png|jpg|jpeg|gif|webp|svg)(\|[^]]+)?\]\]|!\[[^]]*\]\([^)]+\.(png|jpg|jpeg|gif|webp|svg)\)' "$file" 2>/dev/null \
    | sed -E 's/!\[\[([^]|]+)(\|[^]]+)?\]\]/\1/; s/!\[[^]]*\]\(([^)]+)\)/\1/' \
    >> "$IMAGES_LIST" || true
done < "$PUBLISHED_LIST"

# Deduplicate
sort -u "$IMAGES_LIST" -o "$IMAGES_LIST"

IMG_COUNT=$(wc -l < "$IMAGES_LIST" | tr -d ' ')
echo "Found $IMG_COUNT unique image reference(s)"

# --- Copy images ---
while IFS= read -r img; do
  [ -z "$img" ] && continue
  # Image filename only — search the whole vault
  imgname=$(basename "$img")
  found=$(find "$VAULT" -name "$imgname" -not -path "*/.git/*" -not -path "*/.obsidian/*" 2>/dev/null | head -1)
  if [ -n "$found" ]; then
    rel="${found#$VAULT/}"
    dir="$CONTENT/$(dirname "$rel")"
    mkdir -p "$dir"
    cp "$found" "$CONTENT/$rel"
    echo "  ✓ $rel (image)"
  else
    echo "  ✗ NOT FOUND: $img"
  fi
done < "$IMAGES_LIST"

rm -f "$PUBLISHED_LIST" "$IMAGES_LIST"

echo ""
echo "Done. Run 'npx quartz sync' to commit and deploy."
