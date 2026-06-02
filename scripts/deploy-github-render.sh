#!/usr/bin/env bash
# Push to GitHub, then deploy on Render (Blueprint uses render.yaml + Dockerfile).
set -euo pipefail
cd "$(dirname "$0")/.."

if ! command -v gh >/dev/null; then
  echo "Install GitHub CLI: brew install gh"
  exit 1
fi

if ! gh auth status >/dev/null 2>&1; then
  echo "Log in to GitHub first:"
  echo "  gh auth login"
  exit 1
fi

REPO_NAME="${1:-portfolio}"
if git remote get-url origin >/dev/null 2>&1; then
  echo "Remote origin already set; pushing..."
  git push -u origin main
else
  echo "Creating GitHub repo: $REPO_NAME"
  gh repo create "$REPO_NAME" --public --source=. --remote=origin --push
fi

echo ""
echo "Next: https://dashboard.render.com"
echo "  1. New → Blueprint"
echo "  2. Connect repo: $REPO_NAME"
echo "  3. Apply (uses render.yaml — Docker build)"
echo ""
gh repo view --web 2>/dev/null || true
