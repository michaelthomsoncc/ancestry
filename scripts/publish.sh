#!/usr/bin/env bash
set -euo pipefail

# Publish script for ancestry.abbey-terrace.uk
# Run from the family-book directory, e.g.:
#   bash ../ancestry/scripts/publish.sh
#
# Or specify source:
#   bash ../ancestry/scripts/publish.sh /path/to/family-book
#
# It copies the stories and tree visualizer HTML pages to this repo,
# commits, and pushes. This publishes to GitHub Pages (ancestry.abbey-terrace.uk).

SOURCE_DIR="${1:-.}"

if [[ ! -d "$SOURCE_DIR/site" ]]; then
  echo "Error: $SOURCE_DIR/site not found. Run from family-book root or pass the path."
  echo "Usage: $0 [path-to-family-book]"
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$(dirname "$SCRIPT_DIR")"

echo "Source: $SOURCE_DIR"
echo "Target: $TARGET_DIR"

cd "$TARGET_DIR"

# Copy the full interactive tree visualizer (self-contained)
cp -f "$SOURCE_DIR/site/family-tree-visual.html" ./

# Copy stories landing and individual story pages
cp -f "$SOURCE_DIR/site/stories.html" ./
cp -f "$SOURCE_DIR/site/charlotte-bailey.html" ./ 2>/dev/null || true
cp -f "$SOURCE_DIR/site/john-thomson.html" ./ 2>/dev/null || true
cp -f "$SOURCE_DIR/site/john-wharton.html" ./ 2>/dev/null || true
cp -f "$SOURCE_DIR/site/thady-boyle.html" ./ 2>/dev/null || true
cp -f "$SOURCE_DIR/site/example-story.html" ./ 2>/dev/null || true

# Optionally beliefs if wanted
cp -f "$SOURCE_DIR/site/beliefs.html" ./ 2>/dev/null || true

# Also copy the main family tree page if useful (Mermaid etc.)
cp -f "$SOURCE_DIR/site/family-tree.html" ./ 2>/dev/null || true

# Keep our custom index and CNAME (they are the landing for this subdomain)
# Do not overwrite index.html unless you want to replace the landing.

echo "Files copied."

# Stage, commit, push
git add family-tree-visual.html stories.html charlotte-bailey.html john-thomson.html john-wharton.html thady-boyle.html example-story.html beliefs.html family-tree.html 2>/dev/null || true

if git diff --staged --quiet; then
  echo "No changes to publish."
else
  git commit -m "Publish: stories + tree visualizer from family-book $(date -I)"
  git push origin main
  echo "Pushed to GitHub. Site will update at https://ancestry.abbey-terrace.uk (after DNS/Pages build)."
fi

echo "Done."