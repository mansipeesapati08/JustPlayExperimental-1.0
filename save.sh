#!/usr/bin/env bash
# Commit locally only. Free. Nothing leaves the machine.
set -euo pipefail

if [ -n "$(git status --porcelain)" ]; then
  git add -A
  git commit -m "${1:-WIP save}"
  echo "Saved locally."
else
  echo "Nothing to save."
fi
