#!/usr/bin/env bash
# Deploy to Netlify ONLY (no commit/push). Costs Netlify build credits.
# Asks for confirmation unless passed -y. Warns on uncommitted/unpushed work.
# Deploys the sanitized _site/ dir built by build-publish-dir.sh, never the repo root.
set -euo pipefail

auto_yes=false
if [ "${1:-}" = "-y" ]; then
  auto_yes=true
fi

if [ -n "$(git status --porcelain)" ]; then
  echo "Warning: you have uncommitted changes." >&2
fi

if [ -n "$(git log origin/main..HEAD 2>/dev/null)" ]; then
  echo "Warning: you have unpushed commits." >&2
fi

if [ "$auto_yes" != true ]; then
  read -r -p "Deploy to Netlify now? This uses build credits. [y/N] " reply
  case "$reply" in
    [yY]*) ;;
    *) echo "Aborted."; exit 1 ;;
  esac
fi

./build-publish-dir.sh
netlify deploy --prod --dir=_site
