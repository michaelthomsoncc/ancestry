# ancestry.abbey-terrace.uk

GitHub Pages site for the ancestry and family stories of Abbey Terrace.

## Custom Domain
- Subdomain: ancestry.abbey-terrace.uk
- Configured via CNAME file.
- Enable GitHub Pages in repo settings (source: main branch, root).
- Set custom domain in Pages settings to `ancestry.abbey-terrace.uk` (and handle DNS at your registrar: CNAME to the GitHub Pages target).

## Content
- `family-tree-visual.html`: Full interactive force-directed family tree visualizer (from family-book).
- `stories.html` and individual story pages: Published family stories.
- `index.html`: Landing page for this subdomain.

## Publishing
Run the publish script from the **family-book** repo root:

```bash
# From family-book directory
bash ../ancestry/scripts/publish.sh
```

Or with explicit path:

```bash
bash ../ancestry/scripts/publish.sh /full/path/to/family-book
```

The script:
- Copies the tree visualizer and selected story HTML pages.
- Commits and pushes.
- This updates the live site on GitHub Pages.

Currently publishes: stories + tree visualization.

## Source
Main content generated from https://github.com/michaelthomsoncc/family-book

This repo is just the published static assets for the ancestry subdomain. 

## Local Development
Just open index.html or the copied pages in a browser. No build step needed for the published files.