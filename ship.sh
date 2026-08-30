#!/usr/bin/env bash
# The everyday command: push.sh + deploy.sh together.
set -euo pipefail

./push.sh "${1:-Update}"
./deploy.sh -y
