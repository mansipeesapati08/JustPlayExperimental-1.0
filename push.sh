#!/usr/bin/env bash
# Commit + push to GitHub. Free. Does NOT deploy.
# Refuses to run off main, strips .env from staging, hard-stops if .env is tracked.
set -euo pipefail

branch="$(git rev-parse --abbrev-ref HEAD)"
if [ "$branch" != "main" ]; then
  echo "Refusing to push: currently on branch '$branch', not 'main'." >&2
  exit 1
fi

if git ls-files --error-unmatch .env >/dev/null 2>&1; then
  echo "Refusing to push: .env is tracked by git. Untrack it before continuing." >&2
  exit 1
fi

git add -A
git reset -- .env >/dev/null 2>&1 || true

if ! git diff --cached --quiet; then
  git commit -m "${1:-Update}"
fi

git push origin main
echo "Pushed to GitHub."
