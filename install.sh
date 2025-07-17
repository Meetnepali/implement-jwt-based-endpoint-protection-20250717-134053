#!/bin/bash
set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "[+] Creating Python virtual environment..."
python3 -m venv "$SCRIPT_DIR/venv"
echo "[+] Activating virtual environment..."
source "$SCRIPT_DIR/venv/bin/activate"
echo "[+] Installing dependencies..."
pip install --upgrade pip >/dev/null 2>&1
pip install -r "$SCRIPT_DIR/requirements.txt"
echo "[+] Building Docker image..."
docker build -t fastapi-email-app .
echo "[+] Docker image built successfully."
