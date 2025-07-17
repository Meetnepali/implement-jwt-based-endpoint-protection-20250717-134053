#!/bin/bash
set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "[+] Running install script..."
bash "$SCRIPT_DIR/install.sh"
echo "[+] Starting FastAPI app container..."
docker rm -f fastapi-email-app-container 2>/dev/null || true
docker run --name fastapi-email-app-container -p 8000:8000 fastapi-email-app &
CONTAINER_PID=$!
sleep 2
echo "[+] FastAPI app should now be running at http://localhost:8000"
echo "See container logs for background email output."
