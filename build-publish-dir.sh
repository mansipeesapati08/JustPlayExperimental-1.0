#!/usr/bin/env bash
# Builds a sanitized publish directory (_site/) for deploy.sh to ship.
# Excludes anything that shouldn't reach a public Netlify deploy:
# git internals, local Netlify state, node_modules, secrets, deploy scripts, and this repo's internal handoff/planning docs.
set -euo pipefail

OUT="_site"
rm -rf "$OUT"
mkdir -p "$OUT"

shopt -s dotglob nullglob
for entry in *; do
  case "$entry" in
    .git|.netlify|node_modules|_site|.env|.env.*|*.sh|HANDOFF.md|.gitignore)
      continue
      ;;
  esac
  cp -r "$entry" "$OUT"/
done

echo "Built sanitized publish dir at $OUT/"
