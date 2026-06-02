#!/usr/bin/env bash
# Expose local student-api (port 8080) on the internet via Cloudflare quick tunnel.
set -euo pipefail
cd "$(dirname "$0")/.."

if ! curl -sf http://localhost:8080/students >/dev/null 2>&1; then
  echo "Starting API on http://localhost:8080 ..."
  ./mvnw -q spring-boot:run &
  for _ in $(seq 1 30); do
    curl -sf http://localhost:8080/students >/dev/null 2>&1 && break
    sleep 2
  done
fi

if ! command -v cloudflared >/dev/null; then
  echo "Install cloudflared: brew install cloudflared"
  exit 1
fi

echo ""
echo "Public URL (share with others):"
echo "  GET  .../students"
echo "  POST .../students"
echo ""
exec cloudflared tunnel --url http://localhost:8080
